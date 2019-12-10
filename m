Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56320118683
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2019 12:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfLJLiT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Dec 2019 06:38:19 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:39321 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbfLJLiS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Dec 2019 06:38:18 -0500
Received: by mail-lj1-f173.google.com with SMTP id e10so19471808ljj.6
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2019 03:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5LnyDU0KmWguwrS7cDtavRO12NccQSxS6Db4rVS+sao=;
        b=PwkgHPbRXuq03aUW8McQdQlTKuD2dS7i84KeO1/K7l1DGGFNCVnWxrtCPWdTjTpA/5
         bQfUAknsaYunJJAicqBUvbSjlh8L0oe9bTWP1uZGfqc5sijnxTTR8RrfsxMEhnr3ccW8
         HCj1g7brCJztIcJZ3MrPppIihzVv4LiBB9Jg8Om57GQxo64ahbOHf8XtsDy35t22FF6I
         7bHPXkoxNZH6ixlnjb7x2xhnQz6C/HEuWC/oXtfWhPJF7WJP1X420XyqIw76Ffb5yVOq
         lihAJwRz+IkWB70im07x7s4AW4NNwNGV8p58v0KgEMXKhOiXPut8B6lrYTjmsmKEwMQg
         Keyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5LnyDU0KmWguwrS7cDtavRO12NccQSxS6Db4rVS+sao=;
        b=IBHQWEwu1hSWfUv9M1UDitk8lBmBU4L+OeMm63vmU+Y8ds4ZUEejR9qYxRG5wsT8BA
         YrJqv3vHKaNohc0rnBBrzVJrvQdg3WKTYt1FjgUCEW52bsqOYpWAB52lg1h/bedcqILo
         YvVLmD5tXSQQedBjnRILhBYRaMl90czcEm7kydfJwEAK9FHkMPC3BvHur1KzKtdRM5fl
         8mYnvWd5Rtnn9nIrGorRdbV9aTneW3MsB+GVz2IXGoK4qHaGBLkpbVXhEaR/+y1tfQ9Q
         72eeCwyR2DW/ttkTGVpcIVUc1ZrwOGMPtDaZKM0pSt+Xme1yMPwMYmZafluNpJXum5yr
         cKnA==
X-Gm-Message-State: APjAAAVxJ+p/obC5T79m91PM7zotspL8HeQYYoVtnQt7menXIrOrfBDQ
        fzK5mIJiQjjuInEdLUuJn4Dh5qQJnQCrPhPBjX+OkA==
X-Google-Smtp-Source: APXvYqz23Nxvy0SzghrkQBgRBshb5LZpYFHdXwCUtdTTU3fzb35e8axz1PKi75+Z4Bga0APARd7uzWDWAIedkAQ+jlU=
X-Received: by 2002:a2e:854c:: with SMTP id u12mr19080933ljj.135.1575977896057;
 Tue, 10 Dec 2019 03:38:16 -0800 (PST)
MIME-Version: 1.0
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Tue, 10 Dec 2019 13:38:04 +0200
Message-ID: <CAE=Ncrb-kMDRgALnvXtKukSVLEw81rqxGv6+XXxg487Q_qLKGA@mail.gmail.com>
Subject: forever growing ima measurement list
To:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Cc:     Elaine R Palmer <erpalmer@us.ibm.com>,
        Ken Goldman <kgold@linux.ibm.com>,
        David Safford <david.safford@ge.com>,
        Konsta Karsisto <konsta.karsisto@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

Looks to me that systems with high uptimes eventually exhaust the
entire kernel memory as there are no limits for the measurement list
size. Problem is pretty bad for systems that have processes that can
create temporary files, such as a browser - each new site visited can
eat some kernel memory that is lost forever (!).  While this can be
tackled via the policy, in some of these cases it is very hard to form
safe policy statements that would strictly define what exactly needs
to be measured. Besides, some of these systems support applications
that the system users can install and such policy statements might
even be impossible as the administrator would never know.

Now, we can attempt to tackle this if there is a common agreement on
what to do with the case. First thing that comes to my mind based on a
comment from Mimi concerning the prior work on the topic by Dave is
that the measurement list should probably get periodically exported to
a file with its own measurement. Rest of the measurement entries would
then get freed, so the system would start again from a clean state
(ie. state where there is only 1 entry in the measurement list, the
older generation list name and the measurement). For remote
attestation of the system you would have to concatenate all the lists
and verify their validity by walking down the chain, starting from the
existing in-kernel measurement that is kept secure. In other words,
each exported list would have a measurement of the earlier generation
list and we would build a simple list chain.

Thoughts?


--
Janne
