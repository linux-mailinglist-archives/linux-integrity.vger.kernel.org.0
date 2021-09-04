Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC0E400BC1
	for <lists+linux-integrity@lfdr.de>; Sat,  4 Sep 2021 17:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbhIDPBO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 4 Sep 2021 11:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236742AbhIDPBO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 4 Sep 2021 11:01:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADBAC061575
        for <linux-integrity@vger.kernel.org>; Sat,  4 Sep 2021 08:00:12 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o39-20020a05600c512700b002e74638b567so1561289wms.2
        for <linux-integrity@vger.kernel.org>; Sat, 04 Sep 2021 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=pq8QdcgdNxjJmg61r8dPGvWyeowRsap/Qds2NQHbQZA=;
        b=ObGanXpy/qG9ZmJ8TQB4Rfph0tmhVaeYW1PNOH2SHKJlCRKGEnGR9IG1o/q+k6CS2Q
         DcJFBorw1R0HVbv5WnEzU7ydMkkdvflpAJbYTdf/FA0TmKAmr9f8AJH+yDNFuzxNGDRV
         YfluqfuvY8qO3SV6L3NXaODBKaZc/j5GrPb3h8hsMIx9C+eWG0BEzzT14B0CLYNaY3Zy
         h1wFbl0ar6t4B6n8lhJvTnm4vs255aO64RMUz2dscNpa7UIPQrpq0nnURTMhb2e6xDM/
         8GyfBBSlhyjNs4xJ3+BCFd+tGYRxZEUQcTk4lC63mD/WxsRG6Ax/M7LTEDS6kBGtWR92
         1p8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=pq8QdcgdNxjJmg61r8dPGvWyeowRsap/Qds2NQHbQZA=;
        b=dYuF7TMCrW/jT9I67MdMX5qhj6UVizMwQf3e2EGlaW63EWJdc+b2mdg9V7B5a3VaJP
         ToVjkB9mNXlg0T9DHxcXyCTN6qYPj3tgY6l4ln9y2sH3/5JtDrtbhsAyCH3t3bSNkpFu
         edc7PenrJ2uGNwocSXBtJdPw3X+1Mk1MT1Rh2HnoXUR/u+N12uQSkFD/v7zb7WCU+qPx
         JDP6WqjJm+biPyWYk3dV+XivcdtMjZIGuck2HGdEf8qLVm0nqbfeiXmDlgZvFZLSEKSu
         gAhjl2RCk6FKe+Vh3gxQtke19UtD1x2isJwiuR685xnT5ZwgvPMw9LpA59VIYupFZptK
         VJkQ==
X-Gm-Message-State: AOAM532dLv7raWib9Q16k9u5DmT2/BGbZN7XWBidQJannIYuPkZ7XPfL
        N5dbJmKlgdVePWr4TYgr4hmDF6d8O4uX36SlzHM=
X-Google-Smtp-Source: ABdhPJyGp1JTkkg0XmlZcjk9dPHD3bfLw8Iz+sfy6ImMaUK0aVXV+Wjd0dmSXSPkYKVjtu78x6KrofOp9HGNTVtPPC4=
X-Received: by 2002:a1c:158:: with SMTP id 85mr3490405wmb.187.1630767610128;
 Sat, 04 Sep 2021 08:00:10 -0700 (PDT)
MIME-Version: 1.0
Reply-To: bouchetb@yandex.com
Sender: oluwa001@gmail.com
Received: by 2002:a1c:4341:0:0:0:0:0 with HTTP; Sat, 4 Sep 2021 08:00:09 -0700 (PDT)
From:   Dr Bryan Bouchet <drbryanbouchet52@gmail.com>
Date:   Sat, 4 Sep 2021 16:00:09 +0100
X-Google-Sender-Auth: Ha-kNOK8ySCU3_MQjzxHCayzle8
Message-ID: <CAJjmsvrRgPXBRQY6iwzOSn=B6GSLsHU6EDQv-3n_8Nz99qVOoA@mail.gmail.com>
Subject: PLEASE RESPOND VERY URGENTLY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dear Friend,

With due respect, i have decided to contact you on a business
transaction that will be beneficial to both of us. At the bank last
account and auditing evaluation, my staffs came across an old account
which was being maintained by a foreign client who we learn was among
the deceased passengers of motor accident on November.2003, the
deceased was unable to run this account since his death. The account
has remained dormant without the knowledge of his family since it was
put in a safe deposit account in the bank for future investment by the clie=
nt.

Since his demise, even the members of his family haven't applied for
claims over this fund and it has been in the safe deposit account
until i discovered that it cannot be claimed since our client is a
foreign national and we are sure that he has no next of kin here to
file claims over the money. As the director of the department, this
discovery was brought to my office so as to decide what is to be done;
I decided to seek ways through which to transfer this money out of the
bank and out of the country too.

The total amount in the account is (18.6 million) with my positions as
a staff of this bank, i am handicapped because i cannot operate
foreign accounts and cannot lay benefice claim over this money. The
client was a foreign national and you will only be asked to act as his
next of kin and i will supply you with all the necessary information
and bank data to assist you in being able to transfer this money to
any bank of your choice where this money could be transferred into.

The total sum will be shared as follows: 50% for me, 50% for you, and
expenses incidental occur during the transfer will be incur by both of
us. The transfer is risk free on both sides hence you are going to
follow my instruction till the fund transfer to your account. Since I
work in this bank that is why you should be confident in the success
of this transaction because you will be updated with information=E2=80=99s =
as
at when desired.

I will wish you to keep this transaction secret and confidential as I
am hoping to retire with my share of this money at the end of
transaction which will be when this money is safety in your account. I
will then come over to your country for sharing according to the
previously agreed percentages. You might even have to advise me on
possibilities of investment in your country or elsewhere of our
choice. May god help you to help me to a restive retirement?

(1) Your full name..............
(2) Your age:................
(3) Sex:.....................
(4) Your telephone number:.................
(5) Your occupation:.....................
(6) Your country:.....................

Yours sincerely,
Dr Bryan Bouchet
