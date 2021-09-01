Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAFA3FD920
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Sep 2021 14:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243931AbhIAMBo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Sep 2021 08:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbhIAMBn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Sep 2021 08:01:43 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0803C061575
        for <linux-integrity@vger.kernel.org>; Wed,  1 Sep 2021 05:00:46 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id r21so2252787qtw.11
        for <linux-integrity@vger.kernel.org>; Wed, 01 Sep 2021 05:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=lzhuG2Umu6RBQD95cJNpu27ju65zKFnxdBTjRa/Vqas=;
        b=cphRBbGzEwIVJAFCzku36DpzY4wdij/+4H8I3j5YbEIBZZ5mTsG1L33mniLzgz6hN7
         kv0fTbcNYsn2Bt3DcjOdlfzVx7VwdCIKjN4yoXR7tqQDkL2sYyqMHsvYHwqSSdDnZLgh
         wCcoq8txiEjUzh/WkixnuK8BS/t/n0ZggMONyJlVroP+i0Bx/9ewvv5Bs3v9qPSoqvNJ
         1QGG75g2Y8/tYCo1JsnhfNkEfDh5jvE2ZtgnJn8+DiDdqlNCQxSyUXp0IZk7NQgowXUD
         jvVkp+qKF233jlzCpIA1Fmn4yCU8oiN0ocXkYV6YoBynV+5p3LMfx28NmnNJkT6F/gzg
         NEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=lzhuG2Umu6RBQD95cJNpu27ju65zKFnxdBTjRa/Vqas=;
        b=ZiCANhyCnWyi5cc4zbfm6jiEf6yBq1PxGnEm54RlNz0bh2QpNLatnIjRg3RsE367mS
         dT8ibl8Gl8vwnblUorAOvcbKc8Yuq7EDaa3461V+8zMD1eKt7Z8SaqdzaY26NmLakIuu
         4CZrDxwEuZdWqU+lRDnjWZe+hdQXnlVOlKm3xPEBBKRWKVsIIZUFEckvE8RyyO+C4b8w
         YsFJYHe3z8wwBAH9HM6kaixDF+j1NF6pYNGGtyjvwQzwV7POq88HPvuocZpPW0hYZpP1
         17o83NDoCpi7y9x3u73TP2JDjC5qC9w3MR+T/4wZwI2GalLXqWhyipjtB5loNZlA8Z8s
         IxMA==
X-Gm-Message-State: AOAM5326J7o6Ll+msWdh3mJx411iyR51qQ+OV5jaPO1RxvGZTQudd2qi
        WRvF+TAQJqpQ+ljd6S8wEGKlsd8dPk05D7hJ1BV8VMMbod0=
X-Google-Smtp-Source: ABdhPJw74AanRN7MZqYXZKbGAJP4ieQExzYv8dNReNL6+wT6hbyoPSbjK7jWjiQ2F5pwlXvl7H36AbqsVgQGAgj2hGk=
X-Received: by 2002:ac8:57d2:: with SMTP id w18mr7800934qta.67.1630497645817;
 Wed, 01 Sep 2021 05:00:45 -0700 (PDT)
MIME-Version: 1.0
From:   Denis Semakin <0xsemakin@gmail.com>
Date:   Wed, 1 Sep 2021 15:00:35 +0300
Message-ID: <CABtpKGVtgwZbvX9j0QNB3FyZkT_LgwHWdpKYijULeBZ1Z+Xw0w@mail.gmail.com>
Subject: IMA namespaces
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello.
A few months ago we started a project dedicated to single IMA namespaces.
Last years there were a number of patch-sets about this problem, e.g.
the last one was from  Krzysztof Struczynski. But no one patch-set
wasn=E2=80=99t applied to the mainline.

Also there is a document (thanks Mimi) that describes the main goal,
architecture and design - =E2=80=9CIMA Namespacing design considerations=E2=
=80=9D.

As a result of investigations: Krzysztof=E2=80=99s patches were successfull=
y
adopted for Linux kernel v5.10.30 and tested,
at least that allowed to study integrity and IMA a source code a
little bit. But that patch-set does not match =E2=80=9C...design
considerations=E2=80=A6=E2=80=9D. Then we may take all patches as a base, u=
se
=E2=80=9CConsiderations=E2=80=A6=E2=80=9D as architecture description and s=
tart to implement
but it is obvious that it does not make sense without community
(review, discussion, etc).

In practice I suggest using the git branch
next-namespacing-experimental for development purposes. Set this
branch to kernel v5.10.30 (it could be different but =E2=80=A6 I used that,
moreover v5.10.x is longterm). After that I and others could start to
send patches and discuss, it would be a normal development process.
For example it could finally help to decide how exactly a new IMA
namespace should be spawned by clone3() or by writing something to a
sysfs file. In my opinion clone3() should be used.

This is the beginning. Without this we cannot move further. I have no
intention to abandon this project. So let=E2=80=99s start.

Best regards,
Denis.
