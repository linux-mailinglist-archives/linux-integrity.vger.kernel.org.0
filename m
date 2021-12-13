Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6C8473385
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Dec 2021 19:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbhLMSGT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Dec 2021 13:06:19 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48726 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbhLMSGT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Dec 2021 13:06:19 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8C8D71F3B9;
        Mon, 13 Dec 2021 18:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639418776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qWxzseejwZyTZ++HZonSBD5ITvu3/IfjEy9A76Uqkn4=;
        b=kB4bbvIeiQDG4KZp40WnqvXCnCB4Rdybk77ruhyUFtfVewTOhpuI63qYS6wtHGe+nqxkYI
        JFDQ6oQ5AAy8Li6vYLF9EesA1ABUWHXpYq7rHXFyKAGhtskOjMduB4u+yNt71wlI3U6NkG
        Zwg6iEuKykO5MGot2faYd2ZWE5HS4s4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639418776;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qWxzseejwZyTZ++HZonSBD5ITvu3/IfjEy9A76Uqkn4=;
        b=PVFq5fsrpjsQQyZPIhYIBlk2Xjufl+SPQnSyz1lfIN9R31Lqt3c3GkwXpmJEm/Q6n7bWoW
        SZ5fQfbtmxtxdeBA==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C4E98A3B84;
        Mon, 13 Dec 2021 18:06:12 +0000 (UTC)
Date:   Mon, 13 Dec 2021 19:06:11 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Philipp Rudo <prudo@redhat.com>
Cc:     keyrings@vger.kernel.org, kexec@lists.infradead.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna <nayna@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
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
        Baoquan He <bhe@redhat.com>, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 6/6] module: Move duplicate mod_check_sig users code
 to mod_parse_sig
Message-ID: <20211213180611.GU117207@kunlun.suse.cz>
References: <cover.1637862358.git.msuchanek@suse.de>
 <d464e1f45d21a29cbbe828dea412206cdc94866b.1637862358.git.msuchanek@suse.de>
 <20211207171034.0b782d82@rhtmp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207171034.0b782d82@rhtmp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

On Tue, Dec 07, 2021 at 05:10:34PM +0100, Philipp Rudo wrote:
> Hi Michal,
> 
> On Thu, 25 Nov 2021 19:02:44 +0100
> Michal Suchanek <msuchanek@suse.de> wrote:
> 
> > Multiple users of mod_check_sig check for the marker, then call
> > mod_check_sig, extract signature length, and remove the signature.
> > 
> > Put this code in one place together with mod_check_sig.
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  include/linux/module_signature.h    |  1 +
> >  kernel/module_signature.c           | 56 ++++++++++++++++++++++++++++-
> >  kernel/module_signing.c             | 26 +++-----------
> >  security/integrity/ima/ima_modsig.c | 22 ++----------
> >  4 files changed, 63 insertions(+), 42 deletions(-)
> > 
> > diff --git a/include/linux/module_signature.h b/include/linux/module_signature.h
> > index 7eb4b00381ac..1343879b72b3 100644
> > --- a/include/linux/module_signature.h
> > +++ b/include/linux/module_signature.h
> > @@ -42,5 +42,6 @@ struct module_signature {
> >  
> >  int mod_check_sig(const struct module_signature *ms, size_t file_len,
> >  		  const char *name);
> > +int mod_parse_sig(const void *data, size_t *len, size_t *sig_len, const char *name);
> >  
> >  #endif /* _LINUX_MODULE_SIGNATURE_H */
> > diff --git a/kernel/module_signature.c b/kernel/module_signature.c
> > index 00132d12487c..784b40575ee4 100644
> > --- a/kernel/module_signature.c
> > +++ b/kernel/module_signature.c
> > @@ -8,14 +8,36 @@
> >  
> >  #include <linux/errno.h>
> >  #include <linux/printk.h>
> > +#include <linux/string.h>
> >  #include <linux/module_signature.h>
> >  #include <asm/byteorder.h>
> >  
> > +/**
> > + * mod_check_sig_marker - check that the given data has signature marker at the end
> > + *
> > + * @data:	Data with appended signature
> > + * @len:	Length of data. Signature marker length is subtracted on success.
> > + */
> > +static inline int mod_check_sig_marker(const void *data, size_t *len)
> 
> I personally don't like it when a function has a "check" in it's name
> as it doesn't describe what the function is checking for. For me

It is consistent with mod_check_sig

> mod_has_sig_marker is much more precise. I would use that instead.

It actually would not because it does more than that.

Thanks

Michal

> 
> Thanks
> Philipp
> 
> > +{
> > +	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
> > +
> > +	if (markerlen > *len)
> > +		return -ENODATA;
> > +
> > +	if (memcmp(data + *len - markerlen, MODULE_SIG_STRING,
> > +		   markerlen))
> > +		return -ENODATA;
> > +
> > +	*len -= markerlen;
> > +	return 0;
> > +}
> > +
> >  /**
> >   * mod_check_sig - check that the given signature is sane
> >   *
> >   * @ms:		Signature to check.
> > - * @file_len:	Size of the file to which @ms is appended.
> > + * @file_len:	Size of the file to which @ms is appended (without the marker).
> >   * @name:	What is being checked. Used for error messages.
> >   */
> >  int mod_check_sig(const struct module_signature *ms, size_t file_len,
> > @@ -44,3 +66,35 @@ int mod_check_sig(const struct module_signature *ms, size_t file_len,
> >  
> >  	return 0;
> >  }
> > +
> > +/**
> > + * mod_parse_sig - check that the given signature is sane and determine signature length
> > + *
> > + * @data:	Data with appended signature.
> > + * @len:	Length of data. Signature and marker length is subtracted on success.
> > + * @sig_len:	Length of signature. Filled on success.
> > + * @name:	What is being checked. Used for error messages.
> > + */
> > +int mod_parse_sig(const void *data, size_t *len, size_t *sig_len, const char *name)
> > +{
> > +	const struct module_signature *sig;
> > +	int rc;
> > +
> > +	rc = mod_check_sig_marker(data, len);
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (*len < sizeof(*sig))
> > +		return -ENODATA;
> > +
> > +	sig = (const struct module_signature *)(data + (*len - sizeof(*sig)));
> > +
> > +	rc = mod_check_sig(sig, *len, name);
> > +	if (rc)
> > +		return rc;
> > +
> > +	*sig_len = be32_to_cpu(sig->sig_len);
> > +	*len -= *sig_len + sizeof(*sig);
> > +
> > +	return 0;
> > +}
> > diff --git a/kernel/module_signing.c b/kernel/module_signing.c
> > index cef72a6f6b5d..02bbca90f467 100644
> > --- a/kernel/module_signing.c
> > +++ b/kernel/module_signing.c
> > @@ -25,35 +25,17 @@ int verify_appended_signature(const void *data, size_t *len,
> >  			      struct key *trusted_keys,
> >  			      enum key_being_used_for purpose)
> >  {
> > -	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
> >  	struct module_signature ms;
> > -	size_t sig_len, modlen = *len;
> > +	size_t sig_len;
> >  	int ret;
> >  
> > -	pr_devel("==>%s %s(,%zu)\n", __func__, key_being_used_for[purpose], modlen);  
> > +	pr_devel("==>%s %s(,%zu)\n", __func__, key_being_used_for[purpose], *len);
> >  
> > -	if (markerlen > modlen)
> > -		return -ENODATA;
> > -
> > -	if (memcmp(data + modlen - markerlen, MODULE_SIG_STRING,
> > -		   markerlen))
> > -		return -ENODATA;
> > -	modlen -= markerlen;
> > -
> > -	if (modlen <= sizeof(ms))
> > -		return -EBADMSG;
> > -
> > -	memcpy(&ms, data + (modlen - sizeof(ms)), sizeof(ms));
> > -
> > -	ret = mod_check_sig(&ms, modlen, key_being_used_for[purpose]);
> > +	ret = mod_parse_sig(data, len, &sig_len, key_being_used_for[purpose]);
> >  	if (ret)
> >  		return ret;
> >  
> > -	sig_len = be32_to_cpu(ms.sig_len);
> > -	modlen -= sig_len + sizeof(ms);
> > -	*len = modlen;
> > -
> > -	return verify_pkcs7_signature(data, modlen, data + modlen, sig_len,
> > +	return verify_pkcs7_signature(data, *len, data + *len, sig_len,
> >  				      trusted_keys,
> >  				      purpose,
> >  				      NULL, NULL);
> > diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
> > index fb25723c65bc..46917eb37fd8 100644
> > --- a/security/integrity/ima/ima_modsig.c
> > +++ b/security/integrity/ima/ima_modsig.c
> > @@ -37,33 +37,17 @@ struct modsig {
> >   *
> >   * Return: 0 on success, error code otherwise.
> >   */
> > -int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
> > +int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t len,
> >  		    struct modsig **modsig)
> >  {
> > -	const size_t marker_len = strlen(MODULE_SIG_STRING);
> > -	const struct module_signature *sig;
> >  	struct modsig *hdr;
> > -	size_t sig_len;
> > -	const void *p;
> > +	size_t sig_len, buf_len = len;
> >  	int rc;
> >  
> > -	if (buf_len <= marker_len + sizeof(*sig))
> > -		return -ENOENT;
> > -
> > -	p = buf + buf_len - marker_len;
> > -	if (memcmp(p, MODULE_SIG_STRING, marker_len))
> > -		return -ENOENT;
> > -
> > -	buf_len -= marker_len;
> > -	sig = (const struct module_signature *)(p - sizeof(*sig));
> > -
> > -	rc = mod_check_sig(sig, buf_len, func_tokens[func]);
> > +	rc = mod_parse_sig(buf, &buf_len, &sig_len, func_tokens[func]);
> >  	if (rc)
> >  		return rc;
> >  
> > -	sig_len = be32_to_cpu(sig->sig_len);
> > -	buf_len -= sig_len + sizeof(*sig);
> > -
> >  	/* Allocate sig_len additional bytes to hold the raw PKCS#7 data. */
> >  	hdr = kzalloc(sizeof(*hdr) + sig_len, GFP_KERNEL);
> >  	if (!hdr)
> 
