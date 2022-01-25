Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B632549BD05
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jan 2022 21:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiAYUYi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jan 2022 15:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiAYUYi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jan 2022 15:24:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B42C06173B;
        Tue, 25 Jan 2022 12:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KaxLT4yCKXHMci2Ybon5KDASpmDJmpN6+4iIGe8FdpY=; b=EU1eiraZoakQWC+gYz4ZPmkklW
        /WGhoQ8fLufSA0c6q+Kjr5M4RHzaBpoZVHKABP+p6Ast0agW/lLifQeStNFgcIqjmkhioplP6LbJu
        1sWuKfgBpaL0IuzeCE2neJLpeLccuMnV5LIxHI90ptVkUUhQYZeit0r5Fxbw5fnJJopucXWyu7rMi
        0XGnqa4Lkw6kju0n6iN82e0i7vMabNyhryKwpC+4sLeR0ueR5khBjKGYpzdwKM/MWHKhzglB0QOlc
        c4GEiJC9cawWTEKv6ZiY7gwqAUsLk/F/9q1LQ8rthGyNT7lGKSO8xwtRCNxyc/ozh8b5RKyVTnjrb
        fo8971aw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCSMn-009UQI-AX; Tue, 25 Jan 2022 20:24:37 +0000
Date:   Tue, 25 Jan 2022 12:24:37 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        Philipp Rudo <prudo@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna <nayna@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Frank van der Linden <fllinden@amazon.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>, buendgen@de.ibm.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 5/6] module: Use key_being_used_for for log messages
 in verify_appended_signature
Message-ID: <YfBchUvuFovYvzEZ@bombadil.infradead.org>
References: <cover.1641900831.git.msuchanek@suse.de>
 <65d9913441b16e27b672cfabbab24fa5c12bee14.1641900831.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d9913441b16e27b672cfabbab24fa5c12bee14.1641900831.git.msuchanek@suse.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 11, 2022 at 12:37:47PM +0100, Michal Suchanek wrote:
> Add value for kexec appended signature and pass in key_being_used_for
> enum rather than a string to verify_appended_signature to produce log
> messages about the signature.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
