import { Component, OnInit } from '@angular/core';
import { ServerService } from '../server.service';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {
  username: string;
  email: string;
  lastname: string;
  last_login: string;

  constructor(private server: ServerService) { }

  ngOnInit() {
    this.server.request('GET', '/profile').subscribe((user: any) => {
      if (user) {
        this.username = user.username;
        this.email = user.email;
        this.lastname = user.lastname;
        this.last_login = user.last_login;
      }
    });
  }
}
