Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9FB11BB99
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 19:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfLKSWT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Dec 2019 13:22:19 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45981 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfLKSWS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Dec 2019 13:22:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so2188603pfg.12
        for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2019 10:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RkNs2t3UEkW3eFHdWggF1KRZU/VQFWaxx2FeTq7CMSA=;
        b=t7H3sISSpXFfclR1GAE/erR/otbe62H4DKa+Y3Sgup7sllKOsyjd3c7iIm6Wi1mrBJ
         yfBFKbEnRGu4I/RgBKfEZLGMoOS6h5A+2m8rPUpgkthZ03Uoy9UyxR6JI7VBr3z/HS2b
         o4OyXoGguGXkCsySmLVaOXGcZLLYy0j90HUGlNx4+OV0lepqjK0XKAyneYz/rxMITkHx
         DjGtKN/G0HS6m0OzzccKJHC3AVJEl0zmkb21XBAp/AGqBtBwS9dGAoH14vDDfzGa84gN
         kxUNAj3u4cWptT8q1G4lGwVGV45w5XDbZlFMGS8ClGGa5cv9lDGD8ibdqtr96QVTevXL
         Jzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RkNs2t3UEkW3eFHdWggF1KRZU/VQFWaxx2FeTq7CMSA=;
        b=Y3IQPbUMdR0aStWoH7zG/791zXChDqXUDebhqG7okXBjb5LLHNA+PnMQnY/XLWyKtX
         JjsLJ1jnBBzxjjYd/b3vShPLLXunYCTdhzGsPe4NjOKNWXignm8Llm/7iw3bufNCutT5
         fdfLXqUUPrO40KDm1x+0Hw+z/aYnyOSKWVYP9yk4njlwS4r1bX4eb3z0BZVgH66QUnnR
         A+LkQcN1Z7Z7BQ9bslTDe73eNitMoaVpbDEZLTEwbgQD9/qxxWCReaoUzvkrqdX+FUcl
         UZW6Paa5lT1JzncFW/S95ZGN/0c4Gm6o1ssKbB1TsSbUS4Uz7YKJt7d6aXvTSHljAZh4
         pK/g==
X-Gm-Message-State: APjAAAUxr0Hl60I74YrOLjL5+XPdlgixR8l2jRsyNe4HjvIW51f/tUD3
        zfIXuZwiEuok8YCyD/Mw+Dl6CA==
X-Google-Smtp-Source: APXvYqwAVfLzn1Ufb7zEMca9k/Ps1NCNDpmvUl1LS7lV/sPPO0wTldiIigBCQbtSd9Az3j6K8DL9YA==
X-Received: by 2002:a65:6088:: with SMTP id t8mr5702029pgu.329.1576088537967;
        Wed, 11 Dec 2019 10:22:17 -0800 (PST)
Received: from debian ([122.164.82.31])
        by smtp.gmail.com with ESMTPSA id a12sm3482648pga.11.2019.12.11.10.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 10:22:17 -0800 (PST)
Date:   Wed, 11 Dec 2019 23:52:11 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     Will Deacon <will@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        jeffrin@rajagiritech.edu.in
Subject: Re: [PROBLEM]:  WARNING: lock held when returning to user space!
 (5.4.1 #16 Tainted: G )
Message-ID: <20191211182211.GB13799@debian>
References: <20191207173420.GA5280@debian>
 <20191209103432.GC3306@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209103432.GC3306@willie-the-truck>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 09, 2019 at 10:34:32AM +0000, Will Deacon wrote: 
> Was this during boot or during some other operation?

It was during boot.

--
software engineer
rajagiri school of engineering and technology

