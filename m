Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7672D49BCFC
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jan 2022 21:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiAYUYF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jan 2022 15:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiAYUXz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jan 2022 15:23:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DC3C06173B;
        Tue, 25 Jan 2022 12:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8jiAAbr8zjyas8ne1Zsnl8EfrMwDftxtsxyZx5EZ57c=; b=Zs3kdWGPYxRaR0Lyl8LsCxUojd
        FFbsw3pyxYrZ3IXIN8AF9RJ2qJ/Bmqcq2TAd6QT97fTEJJEFH59N5EDUXItL67rTvqu9CELDUkQ+i
        Uq1OFX4NMD28J5kX4RmW2tWk2EloLum46S6lt5QX8psuNiE8k3FRvZ5otiABScKNxYFCnOmYjIJ7f
        +Jf+ktkVVjy9xeba6ZX6Vk6EFOOytBwL3uw9rF5ICEep7gNmiJbbL9ISoXGxu/dq8g6Z96luSyUeh
        S4RZni/SQBT61HceEIDWZTN/SkrD1UpDe7IJTO6rRWoQOpjyw970iqk7dkaHA9OIckeBBYkUmjUDv
        rJLNxzvg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCSM3-009UF5-Sa; Tue, 25 Jan 2022 20:23:51 +0000
Date:   Tue, 25 Jan 2022 12:23:51 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Michal Suchanek <msuchanek@suse.de>,
        David Howells <dhowells@redhat.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        Philipp Rudo <prudo@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna <nayna@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v5 4/6] module: strip the signature marker in the
 verification function.
Message-ID: <YfBcVy62MidVTtux@bombadil.infradead.org>
References: <cover.1641900831.git.msuchanek@suse.de>
 <96d29773b9ef418a71b1d8bbfd0a456a0f996ec6.1641900831.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96d29773b9ef418a71b1d8bbfd0a456a0f996ec6.1641900831.git.msuchanek@suse.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 11, 2022 at 12:37:46PM +0100, Michal Suchanek wrote:
> It is stripped by each caller separately.
> 
> Note: this changes the error for kexec_file from EKEYREJECTED to ENODATA
> when the signature marker is missing.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> v3: - Philipp Rudo <prudo@redhat.com>: Update the commit with note about
>       change of raturn value
>     - the module_signature.h is now no longer needed for kexec_file

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
