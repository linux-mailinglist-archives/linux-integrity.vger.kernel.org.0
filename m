Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0686E681B4
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2019 01:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfGNXs2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 14 Jul 2019 19:48:28 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33064 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfGNXs2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 14 Jul 2019 19:48:28 -0400
Received: by mail-ua1-f66.google.com with SMTP id g11so6061055uak.0
        for <linux-integrity@vger.kernel.org>; Sun, 14 Jul 2019 16:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+VxoK8BzlRMiSs9pQ1wC521oLYrOL5MnSAz422Ig70c=;
        b=e5K54UaFPrnDjkVSlOgXhku0iHGeP2h8/Rs819BzODh+M9PpqI3dc1XgA/LZTh2Nwk
         kHlkHOvWUkfcwgLtibSHxWyudDsye8vPHl9ebJ7BE6vs2o6WBI/TiamqY9WwvJ/4p6xj
         5fmB3S7Xi2BZlaN8pi6EQITMnGAazGIEv/UFL0F640P0z9f5n4ZRL28qch0L+rkcvePh
         7Zv0WCoVF74G4vcy5ueN+lFsv/YqULAvYFCZzNafMgfQ3MwvqOCSzmlxeFEX6FRwYlf8
         MjpPteu88MfH3iZkJZnDALA4KtU2ooz2bOXAq3WtiqmwHDk8UVAGxJsftN9Ajj6lOy7B
         x6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+VxoK8BzlRMiSs9pQ1wC521oLYrOL5MnSAz422Ig70c=;
        b=azWBurzoWTj1X9ewiNY+A1u5hYFZROO/50i8Wc2rbcrIO616GD4L+w4CpcWDuJOc1g
         wXNVetZG8QmU5IH5bYTK++oYJq32F9eUqE2EP+v4ynpxdzcr58GfrBsIsTTqsmaSKREe
         /xpWuurASXr1HTGk/xq8Db9gNe/LuQuijyCCTcrhMkGcxwtnj5qu9QDktMPO/hDaM/wQ
         gxoSBSscPcc5vk3dKqRkK2RxjQP8W9kVjrVTxKeGwQwqQZB0Fd0k+aVCUpdiFt/B4T3x
         9m9/XkfVEN1KWrJVFxFJwsb7dQ3BaUf4UV0r+EWWPmr4Z7aY6FBzZsW1UNP661GREDkD
         IOrg==
X-Gm-Message-State: APjAAAXRb72no1xap+otUsVex9bcZA5fDDFiY6sAihu52t0rwAmZ53XI
        /29bxMiMTDvYFx2xGvATnoxtS6nlIG7XYtLhTyTxYg==
X-Google-Smtp-Source: APXvYqyoNvOCAW7u294IYnnRq74pPR9XGoX3yhsVDns5vZ8pOhwtLHV4OG2Pn994GNnjm8Rrx+5CXmP1F14gMHk/yZY=
X-Received: by 2002:a9f:28e4:: with SMTP id d91mr14962162uad.30.1563148106413;
 Sun, 14 Jul 2019 16:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7BC7@ALPMBAPA12.e2k.ad.ge.com>
 <20190711145850.GC25807@ziepe.ca> <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7C56@ALPMBAPA12.e2k.ad.ge.com>
 <20190711185027.GG25807@ziepe.ca> <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7CFE@ALPMBAPA12.e2k.ad.ge.com>
 <CACdnJutS4-N0GgtYPy9GGJ8dVf48VZGF5AFL2raB55bSPKUpNw@mail.gmail.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7E2A@ALPMBAPA12.e2k.ad.ge.com>
 <CACdnJutmhRyGjiumXbzai1fTNqcYMRthzTfMsiQgzKFtu3+teA@mail.gmail.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7F56@ALPMBAPA12.e2k.ad.ge.com>
 <CACdnJusqAbBxJTzQttF6DwU1efz336xA4o2uchnV9OFbMB+n1A@mail.gmail.com> <BCA04D5D9A3B764C9B7405BBA4D4A3C035EFF39A@ALPMBAPA12.e2k.ad.ge.com>
In-Reply-To: <BCA04D5D9A3B764C9B7405BBA4D4A3C035EFF39A@ALPMBAPA12.e2k.ad.ge.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Sun, 14 Jul 2019 16:48:14 -0700
Message-ID: <CACdnJuuE8GLnPdgcYqLzpY+8tY7JedYybb9S7QTYH8nccyLGgA@mail.gmail.com>
Subject: Re: [PATCH] tpm_crb - workaround broken ACPI tables
To:     "Safford, David (GE Global Research, US)" <david.safford@ge.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hmm that's weird - that's a surprisingly large region of reserved
space. I've no idea why that would be covered, and it definitely makes
things more complicated.
