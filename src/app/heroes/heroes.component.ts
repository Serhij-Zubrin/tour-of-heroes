import { Component, OnInit } from '@angular/core';

import { Hero } from '../hero';
import { HEROES } from '../mock-heroes';

@Component({
  selector: 'app-heroes',
  templateUrl: './heroes.component.html',
  styleUrls: ['./heroes.component.scss']
})
export class HeroesComponent implements OnInit {
  heroes: Hero[] = HEROES;
  selectedHero?: Hero;

  constructor() { }

  ngOnInit(): void {
  }

  trackByFn(index: number, item: Hero): number {
    return item.id;
  }

  onSelect(hero: Hero): void {
    this.selectedHero = hero;
  }
}
