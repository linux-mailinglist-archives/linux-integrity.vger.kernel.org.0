Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11888ECF3
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Apr 2019 00:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbfD2WuZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Apr 2019 18:50:25 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:51631 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729593AbfD2WuZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Apr 2019 18:50:25 -0400
Received: by mail-it1-f180.google.com with SMTP id s3so1739768itk.1
        for <linux-integrity@vger.kernel.org>; Mon, 29 Apr 2019 15:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V4B0GZz0bYMgiQexQTapZYHmjRYio/CoXRebCBRGSMs=;
        b=mAnJCKitGSFHVsvnrXgR6spC9fOTUQUss4Js2+6bMguIk5kKuU7EFj427EBkd/v4wv
         LQ3dxIVnQqWhjZcZrMCaieTyDUWuRpGyifqw4hfQ01RDVPB2uExz5GcskLZWpQd1xwjn
         QaE1o/0bnY0r5/OkfZpZzgObCo19xzT+BApcuT3R3tlUEEbaEcWNXxjTe3lxgkC86bp4
         StE/uB68peedN28gQ2KVK/cMRmhsg5ugLvomrWadmhpy9GsALd7xusQNGhejUyZSwGra
         YI2HTto0scXM3DMbaY0pNU2vuW6rTyUh7C3aWLcs4wyU8ARlWYo1cadEenyhdTTnDtVs
         CkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V4B0GZz0bYMgiQexQTapZYHmjRYio/CoXRebCBRGSMs=;
        b=OKDEy88Vpgdzr9+8uDTI9smRpHpyzvG59kyQBUJ9VP/VTr5vwgfB9BTOQc9UCrE+7e
         BV1lIWQWl+6Ux48QvabiJ9QPQWAMzQ6cxd3NLyPuvU8eZdPCZMqH546SG8QiWOJtFZBn
         PBPcCIILnRtH5lnsXrpnG3HBglklEf0vsX5zjTIUia/K4gj/oboN8z2/s8F+b/AHirzl
         IlPUESvmghiNODAhCqQGq5Vn2k8GyQG+yLIPCtRVSG+5qhD6l6XiTdfpkbUvfFYbXRwL
         Chvm5btGW/htozEY7SD0ycdrwpUTxYIRG/nQhzk5eO/0wsdN3rHZdMp/o62JnTCjQ2sD
         F8+w==
X-Gm-Message-State: APjAAAUc9OkihMz7Iiqo3Sp5K5Ga+O38gbJeO/XnxdMKEnCPKzAo6nAo
        fyU72ftOwXnWBT8tPiMqFwYuA39AC52xA/NMmKC2z3tqbm8=
X-Google-Smtp-Source: APXvYqyt6Y+g7FTesdDesiP307wvTKEHP0s/NzaZ/l4/lhNToRsa8hF5pXzDwIR+XznLPRvljeysHTV0FIKoYZeC9tg=
X-Received: by 2002:a24:a86:: with SMTP id 128mr1247101itw.118.1556578224300;
 Mon, 29 Apr 2019 15:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <f9ad2e46-e458-6c78-76da-b85db4601ee3@linux.microsoft.com>
 <CACdnJuuhiQQ8Uq1A_qfidCLVPVQ_3Ty_Kqg+tQPDx2z3P0Yp9w@mail.gmail.com>
 <6373c67f-ea2f-ae1d-0343-4bb774f1d52f@linux.microsoft.com>
 <CACdnJusXEq=7LXB=Ry0zH4CTRkQLHPC+5DnP07yXi0TNPeCYTw@mail.gmail.com> <b4f9cc9d-bded-fb0a-1d53-40fa1460ddec@linux.microsoft.com>
In-Reply-To: <b4f9cc9d-bded-fb0a-1d53-40fa1460ddec@linux.microsoft.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 29 Apr 2019 15:50:13 -0700
Message-ID: <CACdnJuuK=BqaHLDFU0+zXk539gobvaJFUpHuNL7nYZcpw8E0ZA@mail.gmail.com>
Subject: Re: linux-tpmdd self signed kernel failing to boot with secreboot on
To:     Jordan Hand <jorhand@linux.microsoft.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 29, 2019 at 1:35 PM Jordan Hand <jorhand@linux.microsoft.com> wrote:
> I have tried this both on a Gen2 Hyper-V VM (from a Windows Host) and on
> a Lenovo X1 Carbon with the same results.

Can you let me know which generation of X1 it is? I'll see if I can
borrow one to test.
