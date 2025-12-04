Return-Path: <linux-integrity+bounces-7797-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED09CA440D
	for <lists+linux-integrity@lfdr.de>; Thu, 04 Dec 2025 16:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03D8230BC95D
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Dec 2025 15:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EA8288C2B;
	Thu,  4 Dec 2025 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="VYqrjUQc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73C921D3F2;
	Thu,  4 Dec 2025 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764861631; cv=none; b=KELUq36hIgB3PjPqrIwcY4M/qgrPE4sYi1zLs9DFUhuDIydz1sDpphxGKZGr14zPc+N6CoeMdNbvwoY+jxfKlnl8cuD+UsTif1CcW1paF5r5QsowmR0xkoPAcw4OR5iRLTjR2rSABpoghimb9p9FyYn9Fge4oRpsQ6znIhKGS1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764861631; c=relaxed/simple;
	bh=Iej+RoNCH0jjx3xqFOgTpaEt6k00Gvg14HwpumJeaTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g85wsj/lw57A2r4IO0RnD2p7j5jdw4PVnJuRRHuP0wjbVc3u9EcbE+axzpLZU599f1i0CjhZY2P1D8Iddo/gXCzeBPcTyYU4SwHdWmENQowPp7Wj6rhqBgOJ1nnOpuaEQcdSOAH6M+Q8Se5itBHeXnvvre416D+0DYLANmSsYq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=VYqrjUQc; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=CXDf7uns5ggUWepKyDj26VzDX2KZ8c1McwOyOQroig0=; b=VYqrjUQc3hhpEHo/gxO1QqgHAl
	qou/G3IRJFL/l9cElwWLdHeyFdjHISplJKBcY9ss0CoiMIW5I0pvR5hV+hoMDrKEvhrdvv29KurBP
	4wwS15JI8abWntCxrdkSuzPjiKkoa0IvzrjfzUdLsE8zR3t4QcShpGcQAOIi0Z1a4rr0t//13/xZO
	YpOPyzm/7PRjUijSNUGYU/oPaqF38TENnfmAx4hscV+sRjuSilpclpgaGSWEUieKC2lRohW6DU2Ok
	nAvWm22evVo+EB+1aNRmvic8xuuuY32gfgwC5A25s1+kErDWoCl5T3gXMMYJ53NkyRX2tdaknEFT8
	xNGq1Cig==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1vRB86-0060ww-26;
	Thu, 04 Dec 2025 15:20:26 +0000
Date: Thu, 4 Dec 2025 15:20:26 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3 2/4] tpm2-sessions: Fix tpm2_read_public range checks
Message-ID: <aTGmuhRCbHANjjzV@earth.li>
References: <20251203221215.536031-1-jarkko@kernel.org>
 <20251203221215.536031-3-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251203221215.536031-3-jarkko@kernel.org>

On Thu, Dec 04, 2025 at 12:12:12AM +0200, Jarkko Sakkinen wrote:
>'tpm2_read_public' has some rudimentary range checks but the function
>does not ensure that the response buffer has enough bytes for the full
>TPMT_HA payload.
>
>Re-implement the function with necessary checks and validation.
>
>Cc: stable@vger.kernel.org # v6.10+
>Fixes: d0a25bb961e6 ("tpm: Add HMAC session name/handle append")
>Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

A minor nit about variable naming, but:

Reviewed-by: Jonathan McDowell <noodles@meta.com>

>v2:
>- Made the fix localized instead of spread all over the place.
>---
> drivers/char/tpm/tpm2-cmd.c      |  3 ++
> drivers/char/tpm/tpm2-sessions.c | 77 +++++++++++++++++---------------
> 2 files changed, 44 insertions(+), 36 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>index be4a9c7f2e1a..34e3599f094f 100644
>--- a/drivers/char/tpm/tpm2-cmd.c
>+++ b/drivers/char/tpm/tpm2-cmd.c
>@@ -11,8 +11,11 @@
>  * used by the kernel internally.
>  */
>
>+#include "linux/dev_printk.h"
>+#include "linux/tpm.h"
> #include "tpm.h"
> #include <crypto/hash_info.h>
>+#include <linux/unaligned.h>
>
> static bool disable_pcr_integrity;
> module_param(disable_pcr_integrity, bool, 0444);
>diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
>index a265e9752a5e..e9f439be3916 100644
>--- a/drivers/char/tpm/tpm2-sessions.c
>+++ b/drivers/char/tpm/tpm2-sessions.c
>@@ -163,54 +163,59 @@ static int name_size(const u8 *name)
> 	}
> }
>
>-static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
>+static int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name)
> {
>-	struct tpm_header *head = (struct tpm_header *)buf->data;
>+	u32 mso = tpm2_handle_mso(handle);
> 	off_t offset = TPM_HEADER_SIZE;
>-	u32 tot_len = be32_to_cpu(head->length);
>-	int ret;
>-	u32 val;
>-
>-	/* we're starting after the header so adjust the length */
>-	tot_len -= TPM_HEADER_SIZE;
>-
>-	/* skip public */
>-	val = tpm_buf_read_u16(buf, &offset);
>-	if (val > tot_len)
>-		return -EINVAL;
>-	offset += val;
>-	/* name */
>-
>-	val = tpm_buf_read_u16(buf, &offset);
>-	ret = name_size(&buf->data[offset]);
>-	if (ret < 0)
>-		return ret;
>+	struct tpm_buf buf;
>+	int rc, rc2;
>
>-	if (val != ret)
>+	if (mso != TPM2_MSO_PERSISTENT && mso != TPM2_MSO_VOLATILE &&
>+	    mso != TPM2_MSO_NVRAM)
> 		return -EINVAL;
>
>-	memcpy(name, &buf->data[offset], val);
>-	/* forget the rest */
>-	return 0;
>-}
>-
>-static int tpm2_read_public(struct tpm_chip *chip, u32 handle, char *name)
>-{
>-	struct tpm_buf buf;
>-	int rc;
>-
> 	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_READ_PUBLIC);
> 	if (rc)
> 		return rc;
>
> 	tpm_buf_append_u32(&buf, handle);
>-	rc = tpm_transmit_cmd(chip, &buf, 0, "read public");
>-	if (rc == TPM2_RC_SUCCESS)
>-		rc = tpm2_parse_read_public(name, &buf);
>
>-	tpm_buf_destroy(&buf);
>+	rc = tpm_transmit_cmd(chip, &buf, 0, "TPM2_ReadPublic");
>+	if (rc) {
>+		tpm_buf_destroy(&buf);
>+		return tpm_ret_to_err(rc);
>+	}
>
>-	return rc;
>+	/* Skip TPMT_PUBLIC: */
>+	offset += tpm_buf_read_u16(&buf, &offset);
>+
>+	/*
>+	 * Ensure space for the length field of TPM2B_NAME and hashAlg field of
>+	 * TPMT_HA (the extra four bytes).
>+	 */
>+	if (offset + 4 > tpm_buf_length(&buf)) {
>+		tpm_buf_destroy(&buf);
>+		return -EIO;
>+	}
>+
>+	rc = tpm_buf_read_u16(&buf, &offset);
>+	rc2 = name_size(&buf.data[offset]);

rc2 is not great naming. We only use it for this, so perhaps name_len?

>+
>+	if (rc2 < 0)
>+		return rc2;
>+
>+	if (rc != rc2) {
>+		tpm_buf_destroy(&buf);
>+		return -EIO;
>+	}
>+
>+	if (offset + rc > tpm_buf_length(&buf)) {
>+		tpm_buf_destroy(&buf);
>+		return -EIO;
>+	}
>+
>+	memcpy(name, &buf.data[offset], rc);
>+	return 0;
> }
> #endif /* CONFIG_TCG_TPM2_HMAC */
>
>-- 
>2.52.0
>

J.

-- 
Web [   Pretty please, with sugar on top, clean the f**king car.   ]
site: https:// [                                          ]      Made by
www.earth.li/~noodles/  [                      ]         HuggieTag 0.0.24

