Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 539B9B92A0
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Sep 2019 16:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391686AbfITOeX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Sep 2019 10:34:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:46671 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391539AbfITOeH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Sep 2019 10:34:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2019 07:34:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,528,1559545200"; 
   d="scan'208";a="192381258"
Received: from eergin-mobl.ger.corp.intel.com (HELO localhost) ([10.252.40.12])
  by orsmga006.jf.intel.com with ESMTP; 20 Sep 2019 07:34:03 -0700
Date:   Fri, 20 Sep 2019 17:34:00 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v6 05/12] tpm2-sessions: Add full HMAC and
 encrypt/decrypt session handling
Message-ID: <20190920143337.GD9578@linux.intel.com>
References: <1568031408.6613.29.camel@HansenPartnership.com>
 <1568031657.6613.34.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568031657.6613.34.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 09, 2019 at 01:20:57PM +0100, James Bottomley wrote:
> This code adds true session based HMAC authentication plus parameter
> decryption and response encryption using AES.
> 
> The basic design of this code is to segregate all the nasty crypto,
> hash and hmac code into tpm2-sessions.c and export a usable API.
> 
> The API first of all starts off by gaining a session with
> 
> tpm2_start_auth_session()
> 
> Which initiates a session with the TPM and allocates an opaque
> tpm2_auth structure to handle the session parameters.  Then the use is
> simply:
> 
> * tpm_buf_append_name() in place of the tpm_buf_append_u32 for the
>   handles
> 
> * tpm_buf_append_hmac_session() where tpm2_append_auth() would go
> 
> * tpm_buf_fill_hmac_session() called after the entire command buffer
>   is finished but before tpm_transmit_cmd() is called which computes
>   the correct HMAC and places it in the command at the correct
>   location.
> 
> Finally, after tpm_transmit_cmd() is called,
> tpm_buf_check_hmac_response() is called to check that the returned
> HMAC matched and collect the new state for the next use of the
> session, if any.
> 
> The features of the session is controlled by the session attributes
> set in tpm_buf_append_hmac_session().  If TPM2_SA_CONTINUE_SESSION is
> not specified, the session will be flushed and the tpm2_auth structure
> freed in tpm_buf_check_hmac_response(); otherwise the session may be
> used again.  Parameter encryption is specified by or'ing the flag
> TPM2_SA_DECRYPT and response encryption by or'ing the flag
> TPM2_SA_ENCRYPT.  the various encryptions will be taken care of by
> tpm_buf_fill_hmac_session() and tpm_buf_check_hmac_response()
> respectively.
> 
> To get all of this to work securely, the Kernel now needs a primary
> key to encrypt the session salt to, so we derive an EC key from the
> NULL seed and save its context in the tpm_chip structure.  The context
> is loaded on demand into an available volatile handle when
> tpm_start_auth_session() is called, but is flushed before that
> function exits to conserve handles.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org> # crypto API parts
> 
> ---
> 
> v2: Added docbook and improved response check API
> v3: Add readpublic, fix hmac length, add API for close on error
>     allow for the hmac session not being first in the sessions
> v4: Make NULL seed template exactly match the SRK ECC template.
>     Also check the NULL primary key name is what getpublic returns
>     to prevent spoofing.  Also parametrise the name size for reuse
> v5: Move to sync_skcipher API
> v6: eliminate kernel space and use context save for null seed and
>     make feature conditional on CONFIG_TPM_BUS_SECURITY
> ---
>  drivers/char/tpm/Kconfig         |   11 +
>  drivers/char/tpm/Makefile        |    1 +
>  drivers/char/tpm/tpm-buf.c       |    1 +
>  drivers/char/tpm/tpm.h           |   20 +-
>  drivers/char/tpm/tpm2-cmd.c      |   22 +-
>  drivers/char/tpm/tpm2-sessions.c | 1203 ++++++++++++++++++++++++++++++++++++++
>  drivers/char/tpm/tpm2-sessions.h |  137 +++++
>  include/linux/tpm.h              |   29 +
>  8 files changed, 1411 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/char/tpm/tpm2-sessions.c
>  create mode 100644 drivers/char/tpm/tpm2-sessions.h
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 88a3c06fc153..96b09adfc163 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -9,6 +9,9 @@ menuconfig TCG_TPM
>  	imply SECURITYFS
>  	select CRYPTO
>  	select CRYPTO_HASH_INFO
> +	select CRYPTO_ECDH
> +	select CRYPTO_AES
> +	select CRYPTO_CFB
>  	---help---
>  	  If you have a TPM security chip in your system, which
>  	  implements the Trusted Computing Group's specification,
> @@ -27,6 +30,14 @@ menuconfig TCG_TPM
>  
>  if TCG_TPM
>  
> +config TPM_BUS_SECURITY
> +       bool "Use secure transactions on the TPM bus"
> +       default y
> +       ---help---
> +         Setting this causes us to deploy a tamper resistent scheme
> +	 for communicating with the TPM to prevent or detect bus snooping
> +	 attacks like TPM Genie.  Saying Y here adds some encryption overhead
> +	 to all kernel to TPM transactions.
>  config HW_RANDOM_TPM
>  	bool "TPM HW Random Number Generator support"
>  	depends on TCG_TPM && HW_RANDOM && !(TCG_TPM=y && HW_RANDOM=m)
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 78bd025b808a..8f9e58317048 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -17,6 +17,7 @@ tpm-y += eventlog/tpm1.o
>  tpm-y += eventlog/tpm2.o
>  tpm-y += tpm-buf.o
>  
> +tpm-$(CONFIG_TPM_BUS_SECURITY) += tpm2-sessions.o
>  tpm-$(CONFIG_ACPI) += tpm_ppi.o eventlog/acpi.o
>  tpm-$(CONFIG_EFI) += eventlog/efi.o
>  tpm-$(CONFIG_OF) += eventlog/of.o
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index 553adb84b0ac..f56350123a08 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -31,6 +31,7 @@ void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
>  	head->tag = cpu_to_be16(tag);
>  	head->length = cpu_to_be32(sizeof(*head));
>  	head->ordinal = cpu_to_be32(ordinal);
> +	buf->handles = 0;
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_reset);
>  
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 85a7302ddfeb..ebead8e4c3fe 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -80,6 +80,7 @@ enum tpm2_timeouts {
>  enum tpm2_structures {
>  	TPM2_ST_NO_SESSIONS	= 0x8001,
>  	TPM2_ST_SESSIONS	= 0x8002,
> +	TPM2_ST_CREATION	= 0x8021,
>  };
>  
>  /* Indicates from what layer of the software stack the error comes from */
> @@ -116,6 +117,8 @@ enum tpm2_command_codes {
>  	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
>  	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
>  	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
> +	TPM2_CC_READ_PUBLIC		= 0x0173,
> +	TPM2_CC_START_AUTH_SESS		= 0x0176,
>  	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
>  	TPM2_CC_GET_CAPABILITY	        = 0x017A,
>  	TPM2_CC_GET_RANDOM	        = 0x017B,
> @@ -128,6 +131,7 @@ enum tpm2_command_codes {
>  };
>  
>  enum tpm2_permanent_handles {
> +	TPM2_RH_NULL		= 0x40000007,
>  	TPM2_RS_PW		= 0x40000009,
>  };
>  
> @@ -286,7 +290,8 @@ enum tpm_buf_flags {
>  
>  struct tpm_buf {
>  	struct page *data_page;
> -	unsigned int flags;
> +	u8 flags;
> +	u8 handles;
>  	u8 *data;
>  };
>  
> @@ -306,6 +311,9 @@ u8 tpm_get_inc_u8(const u8 **ptr);
>  u16 tpm_get_inc_u16(const u8 **ptr);
>  u32 tpm_get_inc_u32(const u8 **ptr);
>  
> +/* opaque structure, holds auth session parameters like the session key */
> +struct tpm2_auth;
> +
>  extern struct class *tpm_class;
>  extern struct class *tpmrm_class;
>  extern dev_t tpm_devt;
> @@ -408,4 +416,14 @@ int tpm_bios_log_setup(struct tpm_chip *chip);
>  void tpm_bios_log_teardown(struct tpm_chip *chip);
>  int tpm_dev_common_init(void);
>  void tpm_dev_common_exit(void);
> +
> +#ifdef CONFIG_TPM_BUS_SECURITY
> +int tpm2_sessions_init(struct tpm_chip *chip);
> +#else
> +static inline int tpm2_sessions_init(struct tpm_chip *chip)
> +{
> +	return 0;
> +}
> +#endif
> +
>  #endif
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index ba9acae83bff..d120b0a260eb 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -12,17 +12,10 @@
>   */
>  
>  #include "tpm.h"
> +#include "tpm2-sessions.h"
>  #include <crypto/hash_info.h>
>  #include <keys/trusted-type.h>
>  
> -enum tpm2_object_attributes {
> -	TPM2_OA_USER_WITH_AUTH		= BIT(6),
> -};
> -
> -enum tpm2_session_attributes {
> -	TPM2_SA_CONTINUE_SESSION	= BIT(0),
> -};
> -
>  struct tpm2_hash {
>  	unsigned int crypto_id;
>  	unsigned int tpm_id;
> @@ -388,10 +381,10 @@ void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
>   * @hmac: the session HMAC or password, may be NULL if not used
>   * @hmac_len: the session HMAC or password length, maybe 0 if not used
>   */
> -static void tpm2_buf_append_auth(struct tpm_buf *buf, u32 session_handle,
> -				 const u8 *nonce, u16 nonce_len,
> -				 u8 attributes,
> -				 const u8 *hmac, u16 hmac_len)
> +void tpm2_buf_append_auth(struct tpm_buf *buf, u32 session_handle,
> +			  const u8 *nonce, u16 nonce_len,
> +			  u8 attributes,
> +			  const u8 *hmac, u16 hmac_len)
>  {
>  	tpm_buf_append_u32(buf, 9 + nonce_len + hmac_len);
>  	tpm_buf_append_u32(buf, session_handle);
> @@ -1042,6 +1035,11 @@ int tpm2_auto_startup(struct tpm_chip *chip)
>  
>  	rc = tpm2_get_cc_attrs_tbl(chip);
>  
> +	if (rc)
> +		goto out;
> +
> +	rc = tpm2_sessions_init(chip);
> +
>  out:
>  	if (rc > 0)
>  		rc = -ENODEV;
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> new file mode 100644
> index 000000000000..7307f061e5df
> --- /dev/null
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -0,0 +1,1203 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2018 James.Bottomley@HansenPartnership.com

*/

/**
 * DOC: TPM2 Sessions

> + *
> + * Cryptographic helper routines for handling TPM2 sessions for
> + * authorization HMAC and request response encryption.
> + *
> + * The idea is to ensure that every TPM command is HMAC protected by a
> + * session, meaning in-flight tampering would be detected and in
> + * addition all sensitive inputs and responses should be encrypted.
> + *
> + * The basic way this works is to use a TPM feature called salted
> + * sessions where a random secret used in session construction is
> + * encrypted to the public part of a known TPM key.  The problem is we
> + * have no known keys, so initially a primary Elliptic Curve key is
> + * derived from the NULL seed (we use EC because most TPMs generate
> + * these keys much faster than RSA ones).  The curve used is NIST_P256
> + * because that's now mandated to be present in 'TCG TPM v2.0
> + * Provisioning Guidance'
> + *
> + * Threat problems: the initial TPM2_CreatePrimary is not (and cannot
> + * be) session protected, so a clever Man in the Middle could return a
> + * public key they control to this command and from there intercept
> + * and decode all subsequent session based transactions.  The kernel
> + * cannot mitigate this threat but, after boot, userspace can get
> + * proof this has not happened by asking the TPM to certify the NULL
> + * key.  This certification would chain back to the TPM Endorsement
> + * Certificate and prove the NULL seed primary had not been tampered
> + * with and thus all sessions must have been cryptographically secure.
> + * To assist with this, the initial NULL seed public key name is made
> + * available in a sysfs file.
> + *
> + * Use of these functions:
> + *
> + * The design is all the crypto, hash and hmac gunk is confined in this
> + * file and never needs to be seen even by the kernel internal user.  To
> + * the user there's an init function tpm2_sessions_init() that needs to
> + * be called once per TPM which generates the NULL seed primary key.
> + *
> + * Then there are six usage functions:
> + *
> + * tpm2_start_auth_session() which allocates the opaque auth structure
> + *	and gets a session from the TPM.  This must be called before
> + *	any of the following functions.  The session is protected by a
> + *	session_key which is derived from a random salt value
> + *	encrypted to the NULL seed.
> + * tpm2_end_auth_session() kills the session and frees the resources.
> + *	Under normal operation this function is done by
> + *	tpm_buf_check_hmac_response(), so this is only to be used on
> + *	error legs where the latter is not executed.
> + * tpm_buf_append_name() to add a handle to the buffer.  This must be
> + *	used in place of the usual tpm_buf_append_u32() for adding
> + *	handles because handles have to be processed specially when
> + *	calculating the HMAC.  In particular, for NV, volatile and
> + *	permanent objects you now need to provide the name.
> + * tpm_buf_append_hmac_session() which appends the hmac session to the
> + *	buf in the same way tpm_buf_append_auth does().
> + * tpm_buf_fill_hmac_session() This calculates the correct hash and
> + *	places it in the buffer.  It must be called after the complete
> + *	command buffer is finalized so it can fill in the correct HMAC
> + *	based on the parameters.
> + * tpm_buf_check_hmac_response() which checks the session response in
> + *	the buffer and calculates what it should be.  If there's a
> + *	mismatch it will log a warning and return an error.  If
> + *	tpm_buf_append_hmac_session() did not specify
> + *	TPM_SA_CONTINUE_SESSION then the session will be closed (if it
> + *	hasn't been consumed) and the auth structure freed.

Should be reformatted to use kdoc e.g.

1. Documentation block in the file header (the last section in [1]).
2. Proper kdoc's for the functions.

This will allow generation of the documentation from this if done right
(e.g. like DRM people do).

> + */
> +
> +#include "tpm.h"
> +#include "tpm2-sessions.h"
> +
> +#include <linux/random.h>
> +#include <linux/scatterlist.h>
> +
> +#include <asm/unaligned.h>
> +
> +#include <crypto/aes.h>
> +#include <crypto/kpp.h>
> +#include <crypto/ecdh.h>
> +#include <crypto/hash.h>
> +#include <crypto/hmac.h>
> +#include <crypto/skcipher.h>
> +
> +/* if you change to AES256, you only need change this */
> +#define AES_KEYBYTES	AES_KEYSIZE_128

Ugh, this just masks things, please remove.

> +
> +#define AES_KEYBITS	(AES_KEYBYTES*8)
> +#define AUTH_MAX_NAMES	3
> +
> +/*
> + * This is the structure that carries all the auth information (like
> + * session handle, nonces, session key and auth) from use to use it is
> + * designed to be opaque to anything outside.
> + */
> +struct tpm2_auth {
> +	u32 handle;
> +	/*
> +	 * This has two meanings: before tpm_buf_fill_hmac_session()
> +	 * it marks the offset in the buffer of the start of the
> +	 * sessions (i.e. after all the handles).  Once the buffer has
> +	 * been filled it markes the session number of our auth
> +	 * session so we can find it again in the response buffer.
> +	 *
> +	 * The two cases are distinguished because the first offset
> +	 * must always be greater than TPM_HEADER_SIZE and the second
> +	 * must be less than or equal to 5.
> +	 */
> +	u32 session;
> +	/*
> +	 * the size here is variable and set by the size of our_nonce
> +	 * which must be between 16 and the name hash length. we set
> +	 * the maximum sha256 size for the greatest protection
> +	 */
> +	u8 our_nonce[SHA256_DIGEST_SIZE];
> +	u8 tpm_nonce[SHA256_DIGEST_SIZE];
> +	/*
> +	 * the salt is only used across the session command/response
> +	 * after that it can be used as a scratch area
> +	 */
> +	union {
> +		u8 salt[EC_PT_SZ];
> +		/* scratch for key + IV */
> +		u8 scratch[AES_KEYBYTES + AES_BLOCK_SIZE];
> +	};
> +	/*
> +	 * the session key and passphrase are the same size as the
> +	 * name digest (sha256 again).  The session key is constant
> +	 * for the use of the session and the passphrase can change
> +	 * with every invocation.
> +	 *
> +	 * Note: these fields must be adjacent and in this order
> +	 * because several HMAC/KDF schemes use the combination of the
> +	 * session_key and passphrase.
> +	 */
> +	u8 session_key[SHA256_DIGEST_SIZE];
> +	u8 passphrase[SHA256_DIGEST_SIZE];
> +	int passphraselen;
> +	/* saved session attributes */
> +	u8 attrs;
> +	__be32 ordinal;
> +	struct crypto_sync_skcipher *aes;
> +	struct tpm_chip *chip;
> +	/* 3 names of handles: name_h is handle, name is name of handle */
> +	u32 name_h[AUTH_MAX_NAMES];
> +	u8 name[AUTH_MAX_NAMES][2 + SHA256_DIGEST_SIZE];
> +};

Check "kernel-doc for structs, unions, enums, and typedefs" in [1].

Look at iit this way: you've done a lot of work to explain why you
are doing what you are doing and that is great. If we can generate
documentation from it, it will be more accessible to everyone and does
not get buried inside the source tree :-)

[1] https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt

/Jarkko
