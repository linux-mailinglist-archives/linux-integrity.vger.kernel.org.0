Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B19936626A
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Apr 2021 01:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhDTXSL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Apr 2021 19:18:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233964AbhDTXSK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Apr 2021 19:18:10 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13KN2pe7027749;
        Tue, 20 Apr 2021 19:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=1dIihKNheRj3DD52LPeB9StYSyrd5TgRgcCXq/i15VU=;
 b=if536T0lzuNVet6LO1A4M73uVZnbs3Q5RC5RZjAbLW9v0rKYYRis5EY9Av/iHQ44qrKV
 vWTfN1J2xyKB6Bf1a+x+CCK6AtzB4dNY58vakUGRwRCLm4DYskuP7nbJkJ3J3aSgS9hd
 Gb40U8hq9vaRJvb8EzMMluA2WJ3rOZKE5DFdiYdLVrn1f4hakAZnexhGMvzfYapsmzwa
 HHlPjLutGr5qqNvwCmfkVrvCqCnhFoxaVuOfdnOcr8rubtUlDPYfMSSpZi0zZ6/ZyrHo
 do6GgHpFWtmAf05mNvdLxbH/9bELVMTobgy20EqHT3eL1M/Mr2h9kpLTAoKb7gagogzm NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3826pbjg3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 19:17:03 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13KN3Wn4030008;
        Tue, 20 Apr 2021 19:17:03 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3826pbjg3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 19:17:03 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13KNGjOM008572;
        Tue, 20 Apr 2021 23:17:02 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02dal.us.ibm.com with ESMTP id 37yqaad5pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 23:17:02 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13KNH1l420775312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 23:17:01 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 057CB78060;
        Tue, 20 Apr 2021 23:17:01 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A90787805E;
        Tue, 20 Apr 2021 23:16:57 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.85.203.222])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 20 Apr 2021 23:16:57 +0000 (GMT)
Message-ID: <65dcc9fa28833e6beb1eadf98b0ed3402404d693.camel@linux.ibm.com>
Subject: Re: [PATCH v9 1/4] KEYS: trusted: Add generic trusted keys framework
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Sumit Garg <sumit.garg@linaro.org>,
        jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com
Cc:     dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, lhinds@redhat.com,
        erpalmer@us.ibm.com, a.fatoum@pengutronix.de,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Date:   Tue, 20 Apr 2021 16:16:56 -0700
In-Reply-To: <20210301131127.793707-2-sumit.garg@linaro.org>
References: <20210301131127.793707-1-sumit.garg@linaro.org>
         <20210301131127.793707-2-sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Kxqcmd9hhCUhx8lvYAs_EcvRp6NNSOls
X-Proofpoint-ORIG-GUID: HtJEB5WM4I2IjoYGEO79dIhwU6c1Xhpm
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_11:2021-04-20,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200163
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-03-01 at 18:41 +0530, Sumit Garg wrote:
> Current trusted keys framework is tightly coupled to use TPM device
> as an underlying implementation which makes it difficult for
> implementations like Trusted Execution Environment (TEE) etc. to
> provide trusted keys support in case platform doesn't posses a TPM
> device.
> 
> Add a generic trusted keys framework where underlying implementations
> can be easily plugged in. Create struct trusted_key_ops to achieve
> this, which contains necessary functions of a backend.
> 
> Also, define a module parameter in order to select a particular trust
> source in case a platform support multiple trust sources. In case its
> not specified then implementation itetrates through trust sources
> list starting with TPM and assign the first trust source as a backend
> which has initiazed successfully during iteration.
> 
> Note that current implementation only supports a single trust source
> at runtime which is either selectable at compile time or during boot
> via aforementioned module parameter.

You never actually tested this, did you?  I'm now getting EINVAL from
all the trusted TPM key operations because of this patch.

The reason is quite simple:  this function:

> index 000000000000..0db86b44605d
> --- /dev/null
> +++ b/security/keys/trusted-keys/trusted_core.c
[...]
> +static int datablob_parse(char *datablob, struct trusted_key_payload
> *p)
> +{
> +	substring_t args[MAX_OPT_ARGS];
> +	long keylen;
> +	int ret = -EINVAL;
> +	int key_cmd;
> +	char *c;
> +
> +	/* main command */
> +	c = strsep(&datablob, " \t");

Modifies its argument to consume tokens and separates them with NULL.

so the arguments for

keyctl add trusted kmk "new 34 keyhandle=0x81000001"

Go into this function as

datablob="new 34 keyhandle=0x81000001"

After we leave it, it looks like

datablob="new\034\0keyhandle=0x81000001"

However here:

> +static int trusted_instantiate(struct key *key,
> +			       struct key_preparsed_payload *prep)
> +{
> +	struct trusted_key_payload *payload = NULL;
> +	size_t datalen = prep->datalen;
> +	char *datablob;
> +	int ret = 0;
> +	int key_cmd;
> +	size_t key_len;
> +
> +	if (datalen <= 0 || datalen > 32767 || !prep->data)
> +		return -EINVAL;
> +
> +	datablob = kmalloc(datalen + 1, GFP_KERNEL);
> +	if (!datablob)
> +		return -ENOMEM;
> +	memcpy(datablob, prep->data, datalen);
> +	datablob[datalen] = '\0';
> +
> +	payload = trusted_payload_alloc(key);
> +	if (!payload) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	key_cmd = datablob_parse(datablob, payload);
> +	if (key_cmd < 0) {
> +		ret = key_cmd;
> +		goto out;
> +	}
> +
> +	dump_payload(payload);
> +
> +	switch (key_cmd) {
> +	case Opt_load:
> +		ret = static_call(trusted_key_unseal)(payload,
> datablob);

We're passing the unmodified

datablob="new\034\0keyhandle=0x81000001"

Into the tpm trusted_key_unseal function.  However, it only sees "new"
and promply gives EINVAL because you've removed the ability to process
the new option from it.  What should have happened is you should have
moved data blob up to passed the consumed tokens, so it actually reads

datablob="keyhandle=0x81000001"

However, to do that you'd have to have the updated pointer passed out
of your datablob_parse() above.

There's also a lost !tpm2 in the check for options->keyhandle, but I
suspect Jarkko lost that merging the two patches.  I think what's below
fixes all of this, so if you can test it for trusted_tee, I'll package
it up as two separate patches fixing all of this.

James

---

diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index ec3a066a4b42..7c636212429b 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -62,7 +62,7 @@ static const match_table_t key_tokens = {
  *
  * On success returns 0, otherwise -EINVAL.
  */
-static int datablob_parse(char *datablob, struct trusted_key_payload *p)
+static int datablob_parse(char **datablob, struct trusted_key_payload *p)
 {
 	substring_t args[MAX_OPT_ARGS];
 	long keylen;
@@ -71,14 +71,14 @@ static int datablob_parse(char *datablob, struct trusted_key_payload *p)
 	char *c;
 
 	/* main command */
-	c = strsep(&datablob, " \t");
+	c = strsep(datablob, " \t");
 	if (!c)
 		return -EINVAL;
 	key_cmd = match_token(c, key_tokens, args);
 	switch (key_cmd) {
 	case Opt_new:
 		/* first argument is key size */
-		c = strsep(&datablob, " \t");
+		c = strsep(datablob, " \t");
 		if (!c)
 			return -EINVAL;
 		ret = kstrtol(c, 10, &keylen);
@@ -89,7 +89,7 @@ static int datablob_parse(char *datablob, struct trusted_key_payload *p)
 		break;
 	case Opt_load:
 		/* first argument is sealed blob */
-		c = strsep(&datablob, " \t");
+		c = strsep(datablob, " \t");
 		if (!c)
 			return -EINVAL;
 		p->blob_len = strlen(c) / 2;
@@ -138,7 +138,7 @@ static int trusted_instantiate(struct key *key,
 {
 	struct trusted_key_payload *payload = NULL;
 	size_t datalen = prep->datalen;
-	char *datablob;
+	char *datablob, *orig_datablob;
 	int ret = 0;
 	int key_cmd;
 	size_t key_len;
@@ -146,7 +146,7 @@ static int trusted_instantiate(struct key *key,
 	if (datalen <= 0 || datalen > 32767 || !prep->data)
 		return -EINVAL;
 
-	datablob = kmalloc(datalen + 1, GFP_KERNEL);
+	orig_datablob = datablob = kmalloc(datalen + 1, GFP_KERNEL);
 	if (!datablob)
 		return -ENOMEM;
 	memcpy(datablob, prep->data, datalen);
@@ -158,7 +158,7 @@ static int trusted_instantiate(struct key *key,
 		goto out;
 	}
 
-	key_cmd = datablob_parse(datablob, payload);
+	key_cmd = datablob_parse(&datablob, payload);
 	if (key_cmd < 0) {
 		ret = key_cmd;
 		goto out;
@@ -194,7 +194,7 @@ static int trusted_instantiate(struct key *key,
 		ret = -EINVAL;
 	}
 out:
-	kfree_sensitive(datablob);
+	kfree_sensitive(orig_datablob);
 	if (!ret)
 		rcu_assign_keypointer(key, payload);
 	else
@@ -218,7 +218,7 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
 	struct trusted_key_payload *p;
 	struct trusted_key_payload *new_p;
 	size_t datalen = prep->datalen;
-	char *datablob;
+	char *datablob, *orig_datablob;
 	int ret = 0;
 
 	if (key_is_negative(key))
@@ -229,7 +229,7 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
 	if (datalen <= 0 || datalen > 32767 || !prep->data)
 		return -EINVAL;
 
-	datablob = kmalloc(datalen + 1, GFP_KERNEL);
+	orig_datablob = datablob = kmalloc(datalen + 1, GFP_KERNEL);
 	if (!datablob)
 		return -ENOMEM;
 
@@ -241,7 +241,7 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
 
 	memcpy(datablob, prep->data, datalen);
 	datablob[datalen] = '\0';
-	ret = datablob_parse(datablob, new_p);
+	ret = datablob_parse(&datablob, new_p);
 	if (ret != Opt_update) {
 		ret = -EINVAL;
 		kfree_sensitive(new_p);
@@ -265,7 +265,7 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
 	rcu_assign_keypointer(key, new_p);
 	call_rcu(&p->rcu, trusted_rcu_free);
 out:
-	kfree_sensitive(datablob);
+	kfree_sensitive(orig_datablob);
 	return ret;
 }
 
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 4e5c50138f92..bc702ba0a596 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -747,6 +747,9 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 
 	opt->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
 
+	if (!c)
+		return 0;
+
 	while ((p = strsep(&c, " \t"))) {
 		if (*p == '\0' || *p == ' ' || *p == '\t')
 			continue;
@@ -944,7 +947,7 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
 		goto out;
 	dump_options(options);
 
-	if (!options->keyhandle) {
+	if (!options->keyhandle && !tpm2) {
 		ret = -EINVAL;
 		goto out;
 	}


