Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2167C6FADF
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jul 2019 10:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfGVIDi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jul 2019 04:03:38 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:37415 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfGVIDi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jul 2019 04:03:38 -0400
Received: by mail-vs1-f49.google.com with SMTP id v6so25534307vsq.4
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jul 2019 01:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2CULTBdhJhGYX2ATvxajLqNULc6VJNmdRvoPb3WBE5w=;
        b=Mtp6gid+H75KsBZhsv2krMm3hlQ2sC+MxfmAErf+2EeZj22JfF/5He+fm24555/d06
         d5NgEkrw6XNxshKCGzWT0FkceBvkzL8H+ZCtqY0WOYF28zynVX14xzL7HJsBxZWcxWxP
         3MS22hcejeMerpY4rxyqfJPqHT1WZ1etX0x2xkTJIMIC4f+9U0nVVGkogb1bTYxolxSf
         hXVmBaEJ1xpKOe9EgbU1UBHMQRofBolUAh8Y//edXToXa9e6jV1UsPDu5mlHUMrvcAF0
         oXmAdkpyWcvyCeMWJZLBz7SXDfrVD/1823e4cmy/iEJ3q+52fhMllF5QZq5rGHgEOncI
         FB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2CULTBdhJhGYX2ATvxajLqNULc6VJNmdRvoPb3WBE5w=;
        b=GPPBbYXQ7JCJZ07djw/0BwhQ9fiYGHZ3gmYNe3PRx/JDe5Z0Y1SLrgdo0ICDYP9nfM
         lPDAFavOZnTNnri+HaBoT1Asmqz/ZMnCmM7Ap6jyBLiY3R721iA0GBvEa7mMdSK03BsW
         z68b6S5zuD/Mq2i4HxWHLWkpgCo8RjoNweA7/SGKAemT+F5eXFGRKN5v4OHgWwORKeU6
         MAtHrpopZAMlT5wnq5vB0gJ+feIKM1h6m+ToYhzVHkvUpSJoBL83OI6JbS25mwsTMn6A
         TOLODv5gPIJwJGaHgPZqzGsz4uBUIM0PL71G8CzXnAtPITX8J9TYP4zrK67sZ98BRkkq
         onqw==
X-Gm-Message-State: APjAAAXHxx3B1MLeJFuHT5sPpUwBMM56Kd9TIvgNLxKDUWRDfD7Z9am4
        7B6Uv0tH/L34FReA5bTXXpvy5y0jpvXvqPvv2hpqXsNZ
X-Google-Smtp-Source: APXvYqw/pydSXE9UNtTAuVPmokSjZIjqlw8TDmOtrEOYqAFpulK/vEENokx3D5khXZHOizeQ0rC3nK6UZNCPLTtAK1c=
X-Received: by 2002:a67:ce97:: with SMTP id c23mr39988873vse.78.1563782617184;
 Mon, 22 Jul 2019 01:03:37 -0700 (PDT)
MIME-Version: 1.0
From:   Martin Townsend <mtownsend1973@gmail.com>
Date:   Mon, 22 Jul 2019 09:03:25 +0100
Message-ID: <CABatt_yn_yjw-MOUnrPDyg-ZQd1AjaHkcJKxNBo8STC9o2EGrw@mail.gmail.com>
Subject: SMACK and keys
To:     linux-integrity@vger.kernel.org
Cc:     Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

One of our developers has reported the following audit log entry when
trying to add a key to the kernel's keyring when SMACK is enabled:

Jul  9 09:33:23 mach-cw-rnet-ppm-1840 user.notice kernel: audit:
type=1400 audit(1562664803.960:12): lsm=SMACK fn=smack_key_permission
action=denied subject="programmingapp" object="_" requested=w pid=905
comm="programmingapp" key_serial=98475196 key_desc="_ses"

I had a quick look through the code in smack_lsm.c but can't see how
I'm supposed to set a SMACK label for keys or keyrings.  Is it
possible and if so how? We are running a 4.9 Kernel with not much
chance of upgrading as it's a vendor kernel (linux-imx).  As it's an
embedded system we are happy to hard code the SMACK labels into the
kernel if this is possible?  or is it set to '_' by design and we
should add the key whilst the process is a privileged state before the
SMACK label for the process has been set?

Many Thanks,
Martin.
