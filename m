Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C118A49BD0D
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jan 2022 21:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiAYU1P (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jan 2022 15:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiAYU1P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jan 2022 15:27:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE4CC06173B;
        Tue, 25 Jan 2022 12:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3Bb23zhtgzU7Wxmk6KGQnnxzZSeCxUCxB/mlyZEzbkg=; b=jfnP7t3Va434azfa7CGwqEJbQ3
        qHZG/qaQxtDi2ObBW5J1jYfDwVfVM7ZUb5kf4IPYmQuegN1jWD+hLfCoF4eox6NUOrbMDbRDvd01P
        JRJWLy/SP3edGvoUXvlMLgzz1kTXs+G5BrMyJV7syMki25lRyu8gdthFr1hhQvQHZupGC5DWg66N/
        LEQ1I7WT1IB4ucPJrXH5MM71+fYSk0pRh4AF7UjEH0NX75oo6gxDediH1BwVk6Y3UAqpWY5jK9vW+
        tzDWcn98pI0mUU6JoOfNXyWnp1tDG/xMPd+7rh9K+brTE+sbTmSPvJI5KJmcklnDNhzERB4gNoR6J
        gznneLpg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCSPJ-009Utb-SO; Tue, 25 Jan 2022 20:27:13 +0000
Date:   Tue, 25 Jan 2022 12:27:13 -0800
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
Subject: Re: [PATCH v5 6/6] module: Move duplicate mod_check_sig users code
 to mod_parse_sig
Message-ID: <YfBdIdVqOriKF+yA@bombadil.infradead.org>
References: <cover.1641900831.git.msuchanek@suse.de>
 <687db74a714d50b9c83d7ac024da4f7dec0d9a1d.1641900831.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <687db74a714d50b9c83d7ac024da4f7dec0d9a1d.1641900831.git.msuchanek@suse.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 11, 2022 at 12:37:48PM +0100, Michal Suchanek wrote:
> Multiple users of mod_check_sig check for the marker, then call
> mod_check_sig, extract signature length, and remove the signature.
> 
> Put this code in one place together with mod_check_sig.
> 
> This changes the error from ENOENT to ENODATA for ima_read_modsig in the
> case the signature marker is missing.
> 
> This also changes the buffer length in ima_read_modsig from size_t to
> unsigned long. This reduces the possible value range on 32bit but the
> length refers to kernel in-memory buffer which cannot be longer than
> ULONG_MAX.
> 
> Also change mod_check_sig to unsigned long while at it.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
