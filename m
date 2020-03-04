Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68B2F179ABB
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Mar 2020 22:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388026AbgCDVP5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Mar 2020 16:15:57 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40522 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbgCDVP4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Mar 2020 16:15:56 -0500
Received: by mail-ed1-f67.google.com with SMTP id a13so4024447edu.7;
        Wed, 04 Mar 2020 13:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Em+PlQiOtj4b65IT/F3S+R3l1hsqSkR2d5+J1YRJyRk=;
        b=rpIeztq7F3sX6zjxbhir4885stPfdoyMPD7XM/MG+0p0rleBmGcxRh6hHqQHHWaGtK
         +vy/wGjzwyzIopeZohV5yY6ak/lABt6v/tPrtnSUsJEKn4gqlRMQC1EJgoGv9p6dzIK3
         rSe3QedbCh51qJ58HdVOjpWaDEtW20IDvW0Nok67XnkHTlbjJy+Bu89GRlWVGBcGolWS
         l8oC/kj/6rBdc6f/KjxgtJCxojakt7mNhQIdiEsY9mVf0xA+BSYc4HP/3rkZut4QbjpX
         jhCPCMkKNUiTHFZl7jn8GJuEbt04o02iJ3t9o7hofKRomGvtN/uL6aK/3MRPCHiAYlD9
         z5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Em+PlQiOtj4b65IT/F3S+R3l1hsqSkR2d5+J1YRJyRk=;
        b=oI7S5BAd5QV+OboxbAwZEgK7eZgWYQi3goHqzaQmmEEaMpY2FlAluxcu2x7MTwDDMs
         aZHs1ultT5T1BagkFvA5HRA5Q2/qBm6STAuSM8FACpxVwe922QBZHzEOfzZdQunKQrRW
         JmP5TsrT4mUfk9dyb0Cgfxw5sn2/0CpD+oFfJUoCMhXHnT28/OYV9iDxsMUuJnRQZ0t6
         BuEQVvA/kLAAV0h7rEcE4qWxou0eASvVEPe1JThS437ik/2UJE+iu7SsKNVYJHZdGH8s
         jb3NKZdIzqQoLazZFmpq9wZvgv9kg3im280Oj12uwnHSZAsPR8cv0uIdri30ygWPfFko
         h0/A==
X-Gm-Message-State: ANhLgQ3mYNIfFz1D9QrruEIS88slvx7PU5GTphZ3fnzlkoHD7RdFPwJu
        StgmHRVdFTILSudYqgfJwdU=
X-Google-Smtp-Source: ADFU+vsskwQ2kRTF4Kq4c201RyQOGF1Y34XBafQH0inJlyarAtMkOuxBj2qs8K+F/666Z9EL7+gVUw==
X-Received: by 2002:a05:6402:22e9:: with SMTP id dn9mr4702173edb.165.1583356554894;
        Wed, 04 Mar 2020 13:15:54 -0800 (PST)
Received: from felia ([2001:16b8:2d16:4100:5c62:5f:595c:f76d])
        by smtp.gmail.com with ESMTPSA id r25sm610123edo.19.2020.03.04.13.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 13:15:54 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Wed, 4 Mar 2020 22:15:53 +0100 (CET)
X-X-Sender: lukas@felia
To:     James Bottomley <jejb@linux.ibm.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Sebastian Duda <sebastian.duda@fau.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust to trusted keys subsystem creation
In-Reply-To: <1583338378.3284.7.camel@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.2003042214170.2698@felia>
References: <20200304160359.16809-1-lukas.bulwahn@gmail.com> <1583338378.3284.7.camel@linux.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On Wed, 4 Mar 2020, James Bottomley wrote:

> On Wed, 2020-03-04 at 17:03 +0100, Lukas Bulwahn wrote:
> > +F:	include/keys/trusted_tpm.h
> > +F:	security/keys/trusted-keys/trusted_tpm1.c
> 
> Everything under trusted-keys is part of the subsystem, so this should
> be a glob not a single file.
> 

Agree. I sent out a PATCH v2 for that:

https://lore.kernel.org/linux-integrity/20200304211254.5127-1-lukas.bulwahn@gmail.com/T/#u

Please ignore this v1 here and pick v2.

Thanks,

Lukas
