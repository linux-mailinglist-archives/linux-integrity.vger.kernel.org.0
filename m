Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F377D8754
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Oct 2023 19:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345296AbjJZRLY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Oct 2023 13:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbjJZRLW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Oct 2023 13:11:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1531BE
        for <linux-integrity@vger.kernel.org>; Thu, 26 Oct 2023 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698340230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/CIQaN2hYmBCGrEr5wSwlpK+Nw1/R/cDnWMd/K0WyEc=;
        b=DPTnJlBwBqkUXkEzPfaTzbSIp72r4IgaNUTR/eov7+6t8qat5ttyTO4tk/OFEG9RDYzVNu
        N+6tz6IGbcMkV0AO22JW9xUPW8BStri+U6di8D8XWVaPelmyYVAMdPOFSAjkFyYoCx+Bm0
        zse0wyXbh581eSRoZsMyyNMkDuYTG84=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-CEnvvhdTN8aLrVFw1BAQNA-1; Thu, 26 Oct 2023 13:10:29 -0400
X-MC-Unique: CEnvvhdTN8aLrVFw1BAQNA-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6ce25ad9ef2so1402321a34.3
        for <linux-integrity@vger.kernel.org>; Thu, 26 Oct 2023 10:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340229; x=1698945029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CIQaN2hYmBCGrEr5wSwlpK+Nw1/R/cDnWMd/K0WyEc=;
        b=ff+eixPC7bnosbPUKkp9u9KqMK9I6+cO8ImvYSS5lloRtH3gg7gl/BH90DqQBrCk3V
         Sff/PJ6s2dT2CUkjDdL1zKJ76wKQHJVKI7RlpBRBLOVeNKaFG5RxE6xMwoI17XiksMrX
         Xo3tGJmzI7TKTcUyIzII/m+ObX2bgn6qdyKKZl7B9xKc3JOqcZE5Klx+Ki7MrtQuLLcF
         p6TQl8HWgxlHLnv0Kp0AhoqFqc+zPBKtxSXBA/gJ+v8ldMP4rfN4WbUQu+az3+NAoFCf
         olul2WqMXcj7cqzx5zOgz1GHjpjAQolFdKBRqZUNZ0VMEg3wAKtmPhU1KZVh6Rm1O2c9
         MbwA==
X-Gm-Message-State: AOJu0Yw8oEeQHLEXYB0a/kh+Z8slceChaLsk2O+SBhPKEV40AocAryJl
        48akW5R323/rSWqcUlSji4l5NfdoWs7RGX2ZM+Twzu5PR/XfRDhykGmmRMBBdl6kpN6Z/LfblUw
        mU2cWy/nxY0PjtFoEh2FGAwWz1xaB
X-Received: by 2002:a05:6870:700e:b0:1e9:9469:a858 with SMTP id u14-20020a056870700e00b001e99469a858mr177903oae.39.1698340228774;
        Thu, 26 Oct 2023 10:10:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMcG7bFJI3uZvagRkgLSPwdpNdpoULYCl6UniOWGqMYyzyTbNJBhELZeGRoTmo2AKqS168Kw==
X-Received: by 2002:a05:6870:700e:b0:1e9:9469:a858 with SMTP id u14-20020a056870700e00b001e99469a858mr177884oae.39.1698340228525;
        Thu, 26 Oct 2023 10:10:28 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id b23-20020ac86bd7000000b0041969bc2e4csm5160636qtt.32.2023.10.26.10.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:10:28 -0700 (PDT)
Date:   Thu, 26 Oct 2023 10:10:26 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Julien Gomes <julien@arista.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] tpm: Move buffer handling from static inlines to
 real functions
Message-ID: <g6grxamrilogiy4vjrvwwn6iz2xm26oeq2y7redbskvcreil6w@seavf5djd4ph>
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-2-jarkko@kernel.org>
 <qktrbbbqrz3z4jh4h7pz42leikmyg2mdevzl2brapn32kst55e@s5thpstdtlxp>
 <CWHPA3T3YIJT.148L3L98EXBXD@suppilovahvero>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CWHPA3T3YIJT.148L3L98EXBXD@suppilovahvero>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 25, 2023 at 08:35:55PM +0300, Jarkko Sakkinen wrote:
> On Wed Oct 25, 2023 at 12:03 PM EEST, Jerry Snitselaar wrote:
> > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> 
> On Wed, 2023-10-25 at 02:03 -0700, Jerry Snitselaar wrote:
> > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> >
> 
> Thanks I'll add it to the next round.
> 
> For the tpm_buf_read(), I was thinking along the lines of:
> 
> /**
>  * tpm_buf_read() - Read from a TPM buffer
>  * @buf:	&tpm_buf instance
>  * @pos:	position within the buffer
>  * @count:	the number of bytes to read
>  * @output:	the output buffer
>  *
>  * Read bytes from a TPM buffer, and update the position. Returns false when the
>  * amount of bytes requested would overflow the buffer, which is expected to
>  * only happen in the case of hardware failure.
>  */
> static bool tpm_buf_read(const struct tpm_buf *buf, off_t *pos, size_t count, void *output)
> {
> 	off_t next = *pos + count;
> 
> 	if (next >= buf->length) {
> 		pr_warn("%s: %lu >= %lu\n", __func__, next, *offset);
> 		return false;
> 	}
> 
> 	memcpy(output, &buf->data[*pos], count);
> 	*offset = next;
> 	return true;
> }
> 
> BR, Jarkko
> 

Then the callers will check, and return -EIO?

