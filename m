Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E85128FAFD
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Oct 2020 00:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbgJOWBI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Oct 2020 18:01:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32521 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730241AbgJOWBH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Oct 2020 18:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602799266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pDWmqUHLp8FIGfU/X7rfOUyiGs+RfGnhGhcKMN8cq6Q=;
        b=haCOl9g2HGVmwk2IrxkHbDMjSc2oBr3hsEWAqoYr77uECzpbJmShuhIpjSVRpmwfjZYIP6
        xqcr9ypwSmAH31uUq3R7EeKCiQ0wF2XTVyglc7gVdd/6UalcRYYPZUNKEMy/j8CmD3KvDN
        RmuKF2AQLHwiadXkCWUtteZMXXS9Dz8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-zyWRjs4aOzG-YYQzDNne9w-1; Thu, 15 Oct 2020 18:01:05 -0400
X-MC-Unique: zyWRjs4aOzG-YYQzDNne9w-1
Received: by mail-ot1-f70.google.com with SMTP id f4so157089oto.15
        for <linux-integrity@vger.kernel.org>; Thu, 15 Oct 2020 15:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=pDWmqUHLp8FIGfU/X7rfOUyiGs+RfGnhGhcKMN8cq6Q=;
        b=abRLixPrVglr0OZDzF8oXVHhGVfNlbuT/GtUDadFgdTMFQeoXqt7YeX9r2zu1yGxxU
         4JzG0nyL/WY0rspdvzycLD57iz88us68ZgOruLx3d5cizZLb/g02PokUK806Zh/djCzE
         CHhm7Jlj3rmAI77NfMKBzNOGJuSIjuDqG+d+o2yCPGN09JGhGpJL4klR216AIaRIThVU
         4weoGNAGbAk5xLBQGUNMJUxrjK2txu0JdvziYdaI9Nr8ucY9rdhBrnaqdyFgUB9gzI5c
         Cdft9X9/pB4ikXwb1acwH5WPzJgx+0awENmDNqgxFf9pCaL2wZNjKegtcmRrkmtppKMg
         Q9Hg==
X-Gm-Message-State: AOAM531piuZuGevFqCkN0fTyajGlIoi9MogwHUsT9WBr27o1pXRUI8af
        boOA91mYP9VSKIjRBYlA97uTZQ2Kryi1zJNZcKe3AcevtwK+Xln21ypedYymkx2K/sZAyukW1r5
        460L5UUBSEEgyv8YXlvj1Yj1QIMDB
X-Received: by 2002:a9d:6847:: with SMTP id c7mr417953oto.134.1602799264433;
        Thu, 15 Oct 2020 15:01:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxux9nnpe8794oowHdNnMJ76DKX1MNKqZBhVeSffzj8tYw+EXRmhyjkJwc1tly4S0UqOUKlAQ==
X-Received: by 2002:a9d:6847:: with SMTP id c7mr417936oto.134.1602799264234;
        Thu, 15 Oct 2020 15:01:04 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id v123sm178673oif.29.2020.10.15.15.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 15:01:03 -0700 (PDT)
References: <20201015214430.17937-1-jsnitsel@redhat.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-kernel@vger.kernel.org, jarkko@kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: Disable interrupts on ThinkPad T490s
In-reply-to: <20201015214430.17937-1-jsnitsel@redhat.com>
Date:   Thu, 15 Oct 2020 15:01:02 -0700
Message-ID: <87imbbtaht.fsf@jsnitsel.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


James should this get tacked on the end of your patchset?

Regards,
Jerry

