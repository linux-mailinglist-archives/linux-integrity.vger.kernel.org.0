Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51A471AB7B
	for <lists+linux-integrity@lfdr.de>; Sun, 12 May 2019 11:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfELJiB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 12 May 2019 05:38:01 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:34945 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfELJiB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 12 May 2019 05:38:01 -0400
Received: by mail-it1-f195.google.com with SMTP id u186so15905410ith.0
        for <linux-integrity@vger.kernel.org>; Sun, 12 May 2019 02:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=crKU5xz59MyQzphWzB7So6dZFfH+lvgeTNzAWy1i7aI=;
        b=t2KifOKBq2Mywca0ls2mbjUkey2m7eSh/2d9N5ujN2PdYHzdTiUE6fbkusttGHCWTb
         rd3P87kAh2lwsLEIpv5k543Jko/JW6Np49YIFOVwVlCrS4mdqhpzSnpkuWv/nElcFjdA
         /wQmV+rU4ZiDRrJQYJ0iCszMZV4h1izFnNvB/a6dR/jdO0U6R2XayH038dQ7jaq8ypKo
         PzLA6D25ILH01INCGAbdMYsFJwYx6BCsTZhljiW+VCa49DxKRbtks57JXEB2y4Q6/vkK
         78n4D/oBVODSaOT2IiP7cOawhx2pBIABcZGrCVgPVrg+H4exLF/5eG6pkzG0xqU/Bu57
         DqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=crKU5xz59MyQzphWzB7So6dZFfH+lvgeTNzAWy1i7aI=;
        b=kea30o/21yExctlfK9vFMrvCBFuyHEroRdwHskE1X8Qr4/SNlPsfkRdKqFZ4sVrq37
         UYW7sgEAtEar1qr3Wny9ET9+rK9Wf3CwG5dXXJI3beAK+H1iBCznsS2K3FkgKtO+KTnm
         dB7XNDbRXBqxVlbgepNjS+GWXcZ0UNkmW1JDBzoiuP7zlEkOe3NJ7M7OFEoZxqJp3WFV
         f7rUEE1ZeHrlRAV39Ndq1RZxc5njNN04LT/e7bq1gGOTLDWPkaY9xUT2d9uaWNGUjox6
         7rSVp8cRqXrWiEKPwNsmpgrybyboGEcSSCDCq6Jq64Mk7ty8m1JkYfQTg8UrTaRyWLe4
         zFPA==
X-Gm-Message-State: APjAAAUXL/LOX789Lq2uI58Brxo39iKeOYUXo3oJhLg8KCnLNHxiKVe0
        JeEMPCdl923DTuukqpHyBf7vLWQGhKBeprif7F2Bawst
X-Google-Smtp-Source: APXvYqzmPWIoPBgNNjPZLt7Ph8jnS/kebCDQkVKVY/nIO2/YZIhBTeaJOLC4rmA9hzLxGE4AGu+yC8SE4tqpDybc9dM=
X-Received: by 2002:a02:63c7:: with SMTP id j190mr14836762jac.143.1557653880240;
 Sun, 12 May 2019 02:38:00 -0700 (PDT)
MIME-Version: 1.0
From:   m3hm00d <f.m3hm00d@gmail.com>
Date:   Sun, 12 May 2019 09:37:47 +0000
Message-ID: <CAL8qiskDtYJ0NY3u+zV3YBMR4Qs_YcHSHZ61per5jwZ3n54r8A@mail.gmail.com>
Subject: Whitelisting with IMA
To:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

tldr: Is there some way to ask IMA not to open (execute) unknown binaries

Hi all,

I saw some comments on RFC for WhiteEgret LSM. Someone on the same
thread said that IMA could be used for whitelisting as well. Based on
a couple of hours with IMA, it seems to me that IMA can only stop
execution of (altered) binaries whose hash/sign was earlier measured.

If a user installs a new (unknown) application, it seems like IMA is
going to allow that application to run since IMA can't find any
integrity loss since IMA doesn't have any 'good' value against the new
application. Is this correct? Or is there some other option to ask IMA
not to execute any unknown binary?

Kind regards,
m3hm00d
