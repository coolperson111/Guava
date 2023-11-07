import { Component } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';

@Component({
  selector: 'app-book-cab',
  templateUrl: './book-cab.component.html',
  styleUrls: ['./book-cab.component.css']
})
export class BookCabComponent {
  pickup: string;
  dropoff: string;
  bookingResult: string;
  bookingError: string;
  bookingForm: FormGroup;

  constructor(private http: HttpClient, private formBuilder: FormBuilder) {
    this.bookingForm = this.formBuilder.group({
      pickup: ['', Validators.required],
      dropoff: ['', Validators.required]
    });
  }

  bookCab() {
    if (this.bookingForm.invalid) {
      this.bookingError = 'Please fill in both pickup and dropoff locations.';
      return;
    }

    this.bookingError = '';

    const payload = {
      pickup: this.bookingForm.get('pickup').value,
      dropoff: this.bookingForm.get('dropoff').value
    };

    this.http.post('/book_cab', payload)
      .pipe(
        catchError(error => {
          this.bookingError = 'Failed to book the cab. Please try again.';
          return throwError(error);
        })
      )
      .subscribe((response: any) => {
        if (response.success) {
          this.bookingResult = response.message;
          // You can also reset the form here if needed
          this.bookingForm.reset();
        } else {
          this.bookingError = response.message;
        }
      });
  }
}
