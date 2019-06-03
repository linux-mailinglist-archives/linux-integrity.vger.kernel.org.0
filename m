Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCB332904
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jun 2019 08:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfFCG6S (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jun 2019 02:58:18 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43978 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfFCG6S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jun 2019 02:58:18 -0400
Received: by mail-lf1-f65.google.com with SMTP id d7so3142828lfb.10;
        Sun, 02 Jun 2019 23:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQVCYEhO9HM2/zq5Azh8dUDE7ptzD3NHiflaZgm2jxI=;
        b=ApIxlwg4fCLJGjlEs7ObDs5LEYZWm6uH9++wtJb/58kUrxpiHrggHEzNJB1NEv90hx
         p0RMDI/ifxE17d64cdPGXm3vFbc3dPX4CVWj+gcUsSGnHWkipG9678wQ/YYuHevgGmi8
         RRxEQf6NgbY5hFcHocZ7GjJQtm1Uef0aK7O1Br+3WXWvJjQTAoy1LeOyX+AxxQMl+QuA
         3q01vOb6xTS6Mhhh4VSj+iemeOgifgTGWzD6Z0TmWUwLm0E4B97tHS1vOCMDgVu1Bi/F
         3GcsNCXl2mL/DIknr4E1jSNXD3/3DoZCAdRwTMiF4hrERtnohzAKG3mXmpU7xiAnPgYu
         6uVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQVCYEhO9HM2/zq5Azh8dUDE7ptzD3NHiflaZgm2jxI=;
        b=JoYWEQhb1Ib9ZigtEUnnWHoaHUPWvDEx810Cuug4cNr1n+cOvEWYqB2npjKpXr8HbU
         i/T/N+Rg4Yvy13XQQQARW2aDbLk9eBmrJhXaMmP8sDWk82b9BvWBZy5KzkyCgy289YY9
         opEZ9+B2TjWFnBziQ/vlNPrDLx8Il6aiwNyUvwnOV/YR5qt0/hq8ES6ovcaoYuaiVicW
         epqio3A/2kDhqfc8ut/IWLQIz+7zNq0GytikuaoNIbf97vxlbqxwjpEzab3FjjxOgYWN
         opuLz2fX7mTkVXpaKHjSo9Uo7cBI+DMRaB+bECY6M2e7b6hNrwHc2scC2l3H6q9EEORO
         ed+w==
X-Gm-Message-State: APjAAAU/o18AtTIH9tyGoUSl7afF7od9RYBZXBJHF2XN4d5U6hLb8uwd
        Swt5kZdzhCyZPNVyff4d/UB+TeynlZLg8WWZ5Mzz5eZu
X-Google-Smtp-Source: APXvYqxfVrx08HEgWPkBwcIal5QFOQNu1bW+VPdR2IudRWJSLh1ZLfIx4i033Nex0e0rnaRgOeW8JGP97KcuaoueI4E=
X-Received: by 2002:ac2:434c:: with SMTP id o12mr12721266lfl.128.1559545096087;
 Sun, 02 Jun 2019 23:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190531140237.9199-1-janne.karhunen@gmail.com>
 <20190531140237.9199-2-janne.karhunen@gmail.com> <7a0f17c6-5332-fd48-2727-1f1e2649d356@tycho.nsa.gov>
In-Reply-To: <7a0f17c6-5332-fd48-2727-1f1e2649d356@tycho.nsa.gov>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Mon, 3 Jun 2019 09:58:05 +0300
Message-ID: <CAE=Ncraup2xo+WeOkcQukuDs86=+_0GiL65O5ffoytKsgbA1oQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ima: use the lsm policy update notifier
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 31, 2019 at 9:35 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:

> > +                     entry->lsm[i].rule = rule_new;
>
> Doesn't this still leak the old entry->lsm[i].rule?

Argh, clearly got a wrong understanding from different part of the
code. Will fix.


> Also, I don't think you can just mutate entry like this under RCU.

Yeah, it's definitely not the politically correct way of doing it.
Let's rework the entire list then, I will post another draft. It will
become somewhat more intrusive :-(


--
Janne
