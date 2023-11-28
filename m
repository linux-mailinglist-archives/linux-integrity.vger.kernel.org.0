Return-Path: <linux-integrity+bounces-263-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E0B7FBD01
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 15:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA901C20CBA
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 14:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F111524CB;
	Tue, 28 Nov 2023 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B661B5
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 06:42:37 -0800 (PST)
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id D24E3664; Tue, 28 Nov 2023 08:42:35 -0600 (CST)
Date: Tue, 28 Nov 2023 08:42:35 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	William Roberts <bill.c.roberts@gmail.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	David Howells <dhowells@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH v5 0/8] Extend struct tpm_buf to support sized buffers
 (TPM2B)
Message-ID: <20231128144235.GA44537@mail.hallyn.com>
References: <20231121223130.30824-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121223130.30824-1-jarkko@kernel.org>

On Wed, Nov 22, 2023 at 12:31:12AM +0200, Jarkko Sakkinen wrote:
> This patch set extends struct tpm_buf to support TPM2 sized buffers, and
> adds reader functions for parsing more complex response data.  It is
> implemented to support smooth landing of [2]. Sealing of the TPM2 trusted
> keys is updated to utilize the new functionality, and thus provides a
> legit test case for it.
> 
> TPM2 sized buffer, i.e. the buffers in TPM2 format, are defined in the
> section 10.4 of the TPM2 Structures [1] specification.
> 
> Here's the smoke test that I've run for TPM2:
> 
> /usr/lib/kselftests/run_kselftest.sh
> tpm2_createprimary --hierarchy o -G rsa2048 -c key.ctxt
> tpm2_evictcontrol -c key.ctxt 0x81000001
> keyctl add trusted kmk "new 32 keyhandle=0x81000001" @u
> keyctl add encrypted 1000100010001000 "new ecryptfs trusted:kmk 64" @u
> 
> [1] https://trustedcomputinggroup.org/resource/tpm-library-specification/
> [2] https://lore.kernel.org/linux-integrity/20230403214003.32093-1-James.Bottomley@HansenPartnership.com/
> 
> v5:
> - Fixed glitch in tpm_buf_read() reported by James Bottomley to the v4.
>   Was forgotten from v4.
> - Remove a spurious memset() call introduced in v4.
> - Allow command buffer tag to be initially set to zero (caused spurious
>   warnings).
> v4:
> - Cleaned up the bit too spread code changes based on the v3 review.
> - For testing instructions see the previous cover letter, and use
>   linux-v6.6.y branch:
>   https://lore.kernel.org/linux-integrity/20231024011531.442587-1-jarkko@kernel.org/
> v3:
> - Resend with rebase to the latest upstream.
> 
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: William Roberts <bill.c.roberts@gmail.com> 
> Cc: Stefan Berger <stefanb@linux.ibm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Jerry Snitselaar <jsnitsel@redhat.com>

I'm not an expert in this area, but my interest is piqued when I see
tpm/tpm2, so I took a pretty close look, and all looked good to me

Reviewed-by: Serge Hallyn <serge@hallyn.com>

