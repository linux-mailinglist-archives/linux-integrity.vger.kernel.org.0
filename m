Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEF93D6C4C
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 05:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhG0CZc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 22:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234726AbhG0CZc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 22:25:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7785460FED;
        Tue, 27 Jul 2021 03:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627355160;
        bh=QtxTWh/n8Biop96HKPZsq5PVSMW3Hbl5Tg3HH+a4+4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LpZhvKa5lhQNpDms8e1wK8b1K9zDLAsW54cyOuhmWLvw8yv2mTIbKglf+h7n6w0oh
         4hdU1NM+X85DVtipQipwGwtUNWOucpc0wj7kZqxIs9KSVOuknVRlm+avmVCqaosKvI
         EoECXGHKeZW5TYuE32wZbh105FIduEPplPDotaT8BTZprfZNIpvuRmrMBSfswoU94z
         eHZkEUhLfwZmG75LsHttpZVd+tjkxOu+k/JW7/mqLbatEBe9E194luuXgR6oIAZveV
         ixT+AgHizxF+WRE8X1JIdnzWQDInxodqJ2m5m/kEkFCmuSgoHGAwFULhI4JNxT8Ria
         8755UjQW+aqQA==
Date:   Tue, 27 Jul 2021 06:05:57 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: keys: trusted: Fix memory leaks on allocated
 blob
Message-ID: <20210727030557.q7jxepbxh5radvlw@kernel.org>
References: <20210723172121.156687-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723172121.156687-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 23, 2021 at 06:21:21PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are several error return paths that don't kfree the allocated
> blob, leading to memory leaks. Ensure blob is initialized to null as
> some of the error return paths in function tpm2_key_decode do not
> change blob. Add an error return path to kfree blob and use this on
> the current leaky returns.
> 
> Addresses-Coverity: ("Resource leak")
> Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
 
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Probably makes sense (for me) to add also

Cc: stable@vger.kernel.org

?

/Jarkko
