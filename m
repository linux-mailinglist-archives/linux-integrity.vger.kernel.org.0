Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CB4346583
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Mar 2021 17:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhCWQlT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Mar 2021 12:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbhCWQlN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Mar 2021 12:41:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8B7C061574
        for <linux-integrity@vger.kernel.org>; Tue, 23 Mar 2021 09:41:12 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lOk5c-0005iX-20; Tue, 23 Mar 2021 17:41:08 +0100
Subject: Re: [PATCH v1 1/3] crypto: caam - add in-kernel interface for blob
 generator
To:     =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
 <420d2319e533ac97965fb826a70bdb023af2a844.1615914058.git-series.a.fatoum@pengutronix.de>
 <76cd2a74-f522-34c0-eb8c-3047e3cab5cd@nxp.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <880516db-5939-d4cd-100c-69cd85532d39@pengutronix.de>
Date:   Tue, 23 Mar 2021 17:41:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <76cd2a74-f522-34c0-eb8c-3047e3cab5cd@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Horia,

On 21.03.21 21:46, Horia Geantă wrote:
> On 3/16/2021 7:01 PM, Ahmad Fatoum wrote:
>> +	init_job_desc(desc, 0);
>> +	append_key_as_imm(desc, keymod, keymod_len, keymod_len,
>> +			  CLASS_2 | KEY_DEST_CLASS_REG);
>> +	append_seq_in_ptr(desc, dma_in, length - CAAM_BLOB_OVERHEAD, 0);
>> +	append_seq_out_ptr(desc, dma_out, length, 0);
> In case length is known to be < 2^16, it's recommended to use instead
> append_seq_in_ptr_intlen, append_seq_out_ptr_intlen.

Didn't know about this one. Will look into using it for v2.

>> +#define CAAM_BLOB_KEYMOD_LENGTH		16
> The define isn't used here or on patch 3/3.

Will drop and adjust the function docs to note the maximum modifier length.


>> +#define CAAM_BLOB_OVERHEAD		(32 + 16)
>> +#define CAAM_BLOB_MAX_LEN		4096
>> +
>> +struct caam_blob_priv;
>> +
>> +/** caam_blob_gen_init - initialize blob generation
>> + *
>> + * returns either pointer to new caam_blob_priv instance
>> + * or error pointer
>> + */
>> +struct caam_blob_priv *caam_blob_gen_init(void);
>> +
>> +/** caam_blob_gen_init - free blob generation resources
>> + *
>> + * @priv: instance returned by caam_blob_gen_init
>> + */
>> +void caam_blob_gen_exit(struct caam_blob_priv *priv);
>> +
>> +/** caam_encap_blob - encapsulate blob
>> + *
>> + * @priv:   instance returned by caam_blob_gen_init
>> + * @keymod: string to use as key modifier for blob encapsulation
>> + * @input:  buffer which CAAM will DMA from
>> + * @output: buffer which CAAM will DMA to
> Is it guaranteed that input, output can be DMA-mapped?

It's expected callers ensure that this is the case. Trusted key buffers
are allocated with kmalloc and can be DMA-mapped.

Thanks for the review,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
