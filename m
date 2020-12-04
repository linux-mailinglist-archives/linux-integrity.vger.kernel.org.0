Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7935C2CF0DE
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Dec 2020 16:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbgLDPjO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Dec 2020 10:39:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:40336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730395AbgLDPjO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Dec 2020 10:39:14 -0500
Date:   Fri, 4 Dec 2020 17:38:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607096313;
        bh=iTThFfM4EWdfNqRekI8Xw/sXCVHPS1MXBYIjkuMK8Ks=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=V7vsQ1s4GxsMXkkDoUlNHfZPeXbbuLJCSXhMiX/9w+dV6iw6wiZ3Awxol5VI5w8Gf
         ka4Y+tRVd/7Z5/XJfmzYbh5+yFBGCpyADJntQIMPG6/KHcnqWqychZ6kf0ExzYWuPv
         Wm+pBJCRKkOW2OuEdKdoOFL8BNSY5UE398cBbF3OG6sDSRrXMOWvawYKDQy71EjXaR
         Omm6q+Q3QhzheEfyLUlc9Sk+c2oJxnXRTQGg+kYRUSJ30ZxFwMe9C2322Y0jXWk11p
         +88w85y3ZnG/KI6BekGYGf+JbNZzhEuBSOmADrfyxN2C/VDKXyfTsucMHaXJCbN2hV
         oCZ8Ek1o67aoA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     =?us-ascii?B?PT9VVEYtOD9RP01pY2thPWMzPWFibF9TYWxhPWMzPWJjbj89?= 
        <mic@digikod.net>, David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?us-ascii?B?PT9VVEYtOD9RP01pY2thPWMzPWFibF9TYWxhPWMzPWJjbj89?= 
        <mic@linux.microsoft.com>, Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 0/9] Enable root to update the blacklist keyring
Message-ID: <20201204153827.GB6337@kernel.org>
References: <80fb0eae-8321-5ae2-8d50-eabbe86981da@digikod.net>
 <20201120180426.922572-1-mic@digikod.net>
 <20201130024011.GA24870@kernel.org>
 <113544.1607090496@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <113544.1607090496@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Dec 04, 2020 at 02:01:36PM +0000, David Howells wrote:
> Mickaël Salaün <mic@digikod.net> wrote:
> 
> > > What would be easiest way to smoke test the changes?
> > 
> > An easy way to test it is to enable the second trusted keyring to
> > dynamically load certificates in the kernel. Then we can create a hash
> > of a valid certificate (but not loaded yet) and sign it as explained in
> > tools/certs/print-cert-tbs-hash.sh (patch 9/9). Once this hash is loaded
> > in the kernel, loading the blacklisted certificate will be denied. We
> > can also test it with a PKCS#7 signature chain, either with the
> > blacklist keyring itself, or with a signed dm-verity image.
> 
> It might also be possible to use the pkcs#7 test key type
> (CONFIG_PKCS7_TEST_KEY) to aid in that.
> 
> David

Thanks, note taken.

/Jarkko
