Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF902946E8
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Oct 2020 05:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411679AbgJUDV1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Oct 2020 23:21:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2411620AbgJUDV1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Oct 2020 23:21:27 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09L3ESZd175301;
        Tue, 20 Oct 2020 23:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=v0Dn4h05hZpuQ0XCNNxFqCgcMKbDdVCE+TRGnwiRQds=;
 b=a0HC8Xj16Ify51dtoNWjH/uXUG33galGvhktg31bidLdpkJRh4AOBnZzTfJxFxvzoRZT
 rm8LhEoDjQnG85EWTqxnQYumtB+v4AzEY4KIdA0oa3BL3x8joeJV9vNS1otRazCQrzbP
 Qh8J82KSzeGLqn68vZXiCQnL0lyguQLFLSUSKpSnwiOBBVrE+SWqJfXsDA4q4I+4zWq4
 zdFXFc/jSqsJ4b7880ayf5pCz5WEEjWifEMOJVZ3Rz8xFUbensrm7nWn0suH3iDUUgtg
 o45Zf39hdcB9pR/RAK6x9XYKT0v/8zgHqBGX9eIAWnLjoQ0TZswbu0kr1UulgwbcIMJ2 2w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34acw986ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 23:21:11 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09L3Fa7R177307;
        Tue, 20 Oct 2020 23:21:10 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34acw986cx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 23:21:10 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09L3CGmP031758;
        Wed, 21 Oct 2020 03:21:08 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 347r88bv5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Oct 2020 03:21:08 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09L3L5tH33620310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Oct 2020 03:21:05 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF6A642047;
        Wed, 21 Oct 2020 03:21:05 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B783D42045;
        Wed, 21 Oct 2020 03:21:01 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.35.199])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Oct 2020 03:21:01 +0000 (GMT)
Message-ID: <8e07f9401c9f7e18fb1453b7b290472c0049c6e6.camel@linux.ibm.com>
Subject: Re: [PATCH v7 1/4] KEYS: trusted: Add generic trusted keys framework
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Sumit Garg <sumit.garg@linaro.org>,
        jarkko.sakkinen@linux.intel.com, jejb@linux.ibm.com
Cc:     dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, lhinds@redhat.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Date:   Tue, 20 Oct 2020 23:21:00 -0400
In-Reply-To: <1602065268-26017-2-git-send-email-sumit.garg@linaro.org>
References: <1602065268-26017-1-git-send-email-sumit.garg@linaro.org>
         <1602065268-26017-2-git-send-email-sumit.garg@linaro.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-21_02:2020-10-20,2020-10-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 impostorscore=0 suspectscore=2 clxscore=1011
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010210025
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-10-07 at 15:37 +0530, Sumit Garg wrote:

> +/*
> + * trusted_destroy - clear and free the key's payload
> + */
> +static void trusted_destroy(struct key *key)
> +{
> +	kfree_sensitive(key->payload.data[0]);
> +}
> +
> +struct key_type key_type_trusted = {
> +	.name = "trusted",
> +	.instantiate = trusted_instantiate,
> +	.update = trusted_update,
> +	.destroy = trusted_destroy,
> +	.describe = user_describe,
> +	.read = trusted_read,
> +};
> +EXPORT_SYMBOL_GPL(key_type_trusted);
> +
> +static int __init init_trusted(void)
> +{
> +	int i, ret = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(trusted_key_sources); i++) {
> +		if (trusted_key_source &&
> +		    strncmp(trusted_key_source, trusted_key_sources[i].name,
> +			    strlen(trusted_key_sources[i].name)))
> +			continue;
> +
> +		trusted_key_ops = trusted_key_sources[i].ops;
> +
> +		ret = trusted_key_ops->init();
> +		if (!ret)
> +			break;
> +	}

In the case when the module paramater isn't specified and both TPM and
TEE are enabled, trusted_key_ops is set to the last source initialized.
After patch 2/4, the last trusted source initialized is TEE.  If the
intention is to limit it to either TPM or TEE, then trusted_key_ops
should have a default value, which could be overwritten at runtime. 
That would address Luke Hind's concerns of making the decision at
compile time.

trusted_key_ops should be defined as __ro_after_init, like is currently
done for other LSM structures.

> +
> +	/*
> +	 * encrypted_keys.ko depends on successful load of this module even if
> +	 * trusted key implementation is not found.
> +	 */
> +	if (ret == -ENODEV)
> +		return 0;
> +
> +	return ret;
> +}
> +
> +static void __exit cleanup_trusted(void)
> +{
> +	trusted_key_ops->exit();

If the intention is really to support both TPM and TEE trusted keys at
the same time, as James suggested, then the same "for" loop as in
init_trusted() is needed here and probably elsewhere.

thanks,

Mimi

