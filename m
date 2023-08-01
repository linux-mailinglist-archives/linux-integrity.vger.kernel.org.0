Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239C476BD37
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Aug 2023 21:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjHATCy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Aug 2023 15:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjHATCx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Aug 2023 15:02:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579AF184
        for <linux-integrity@vger.kernel.org>; Tue,  1 Aug 2023 12:02:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8865616AD
        for <linux-integrity@vger.kernel.org>; Tue,  1 Aug 2023 19:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71600C433B7;
        Tue,  1 Aug 2023 19:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690916571;
        bh=QELR0/VAgEvzHkL6pJaiqVMd5NFnPPFbeIgCxZeiFqk=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=LekJib2hmEP7rOzsvbZ3XD57rkAM99mf29ceW+HF3IaV+WYLEB8vkd7AJOhnbttHi
         f6230wbVhTFqow4q+qWBm/P2uJVkMOwCyJWHWbLYzN+WUVCgPrMLSm+5ef38uo/6d3
         CCeUmsrweBtNJgsvEf+lTNmGJkpxKMyxsBpsjf222rIHHdF7Adu29RziPef9nFX6g2
         XxOl2myyB59y9IkvoWCEzMB7vEmPwacQhAOq7GaDWtfo9C9GuosERC6S43dv+oOSBP
         psb80SRaUN4LP8zMtBxLnxL75G9QHadHgVBDcfCduyw839l3s6aUnboe/bMBnwO5nc
         ZpkwYaslLuPvA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 01 Aug 2023 22:02:45 +0300
Message-Id: <CUHFWAAKMKJN.2EA3ZHLOOPPGB@suppilovahvero>
Cc:     <code@tyhicks.com>, <nramas@linux.microsoft.com>,
        <paul@paul-moore.com>
Subject: Re: [PATCH 1/6] tpm: implement TPM2 function to get update counter
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Tushar Sugandhi" <tusharsu@linux.microsoft.com>,
        <zohar@linux.ibm.com>, <noodles@fb.com>, <bauermann@kolabnow.com>,
        <ebiederm@xmission.com>, <bhe@redhat.com>, <vgoyal@redhat.com>,
        <dyoung@redhat.com>, <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <kexec@lists.infradead.org>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <20230801181917.8535-2-tusharsu@linux.microsoft.com>
In-Reply-To: <20230801181917.8535-2-tusharsu@linux.microsoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The short summary is cryptic to say the least.

"update counter" does not map it to have anything to do with PCRs.

Why not "tpm: Read pcrUpdateCounter field from TPM2_PCR_Read"?

On Tue Aug 1, 2023 at 9:19 PM EEST, Tushar Sugandhi wrote:
> The TPM2_PCR_Read command returns TPM2_PCR_Read Response struct[1].  It
> contains pcrUpdateCounter member which contains the current value of TPM
> PCR update counter.  The update counter provides the number of times the
> PCRs are updated, which is essential for tracking changes and verifying
> system integrity.  Thus, subsystems (like IMA) should measure
> pcrUpdateCounter value.  Although tpm2_pcr_read_out struct is returned
> by tpm2_pcr_read(), it is not used by it's caller function tpm_pcr_read()=
.
> Further, TPM2_PCR_Read Response struct and pcrUpdateCounter is not
> available in tpm1_pcr_read().
>
> PcrUpdateCounter is only needed in a specific case (IMA for measurements)=
.
> Changing tpm_pcr_read() and tpm2_pcr_read() function signature to return
> tpm2_pcr_read_out struct would be a more disruptive change, since these
> functions are used elsewhere too.  Creating separate functions to get
> pcrUpdateCounter when needed would be a cleaner approach.
>
> Add a function, 'tpm2_pcr_get_update_counter()' to retrieve
> the update counter for a given PCR index and algorithm ID on a TPM2 chip.
>
> This function complements existing TPM functionalities such as reading
> and extending PCRs, and enhances the ability to monitor PCR status
> in the Linux Kernel.=20
>
> [1] https://trustedcomputinggroup.org/wp-content/uploads/TCG_TPM2_r1p59_P=
art3_Commands_pub.pdf
> Section 22.4.2, Page 206.
>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>  drivers/char/tpm/tpm.h      |  3 +++
>  drivers/char/tpm/tpm2-cmd.c | 48 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 830014a26609..60489f21d3bd 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -288,6 +288,9 @@ static inline void tpm_add_ppi(struct tpm_chip *chip)
>  int tpm2_get_timeouts(struct tpm_chip *chip);
>  int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>  		  struct tpm_digest *digest, u16 *digest_size_ptr);
> +int tpm2_pcr_get_update_counter(struct tpm_chip *chip,
> +				u32 pcr_idx, u16 alg_id,
> +				u32 *update_counter);

tpm_pcr_read_update_cnt()

>  int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  		    struct tpm_digest *digests);
>  int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 93545be190a5..55f4e102289a 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -216,6 +216,54 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx=
,
>  	return rc;
>  }
> =20
> +/**
> + * tpm2_pcr_get_update_counter() - gets an update counter value for a PC=
R bank
> + * @chip: TPM chip to use
> + * @pcr_idx: PCR index used to retrieve the update counter
> + * @alg_id:	alg id used to retrieve the update counter
> + * @update_counter: output update counter value
> + *
> + * Return: Same as with tpm_transmit_cmd.
> + */
> +int tpm2_pcr_get_update_counter(struct tpm_chip *chip,
> +				u32 pcr_idx, u16 alg_id, u32 *update_counter)
> +{
> +	int rc;
> +	struct tpm_buf buf;
> +	struct tpm2_pcr_read_out *read_out;
> +	u8 pcr_select[TPM2_PCR_SELECT_MIN] =3D {0};
> +
> +	if (pcr_idx >=3D TPM2_PLATFORM_PCR)
> +		return -EINVAL;
> +
> +	if (!update_counter)
> +		return -EINVAL;
> +
> +	rc =3D tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_READ);
> +	if (rc)
> +		return rc;
> +
> +	pcr_select[pcr_idx >> 3] =3D 1 << (pcr_idx & 0x7);
> +
> +	tpm_buf_append_u32(&buf, 1);
> +	tpm_buf_append_u16(&buf, alg_id);
> +	tpm_buf_append_u8(&buf, TPM2_PCR_SELECT_MIN);
> +	tpm_buf_append(&buf, (const unsigned char *)pcr_select,
> +		       sizeof(pcr_select));
> +
> +	rc =3D tpm_transmit_cmd(chip, &buf, 0, "attempting to read a pcr value"=
);
> +	if (rc)
> +		goto out;
> +
> +	read_out =3D (struct tpm2_pcr_read_out *)&buf.data[TPM_HEADER_SIZE];
> +
> +	*update_counter =3D be32_to_cpu(read_out->update_cnt);
> +
> +out:
> +	tpm_buf_destroy(&buf);
> +	return rc;
> +}
> +
>  struct tpm2_null_auth_area {
>  	__be32  handle;
>  	__be16  nonce_size;
> --=20
> 2.25.1

BR, Jarkko
