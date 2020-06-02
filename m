Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCBD1EBE61
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jun 2020 16:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgFBOox (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Jun 2020 10:44:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726217AbgFBOow (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Jun 2020 10:44:52 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 052EWRur014054;
        Tue, 2 Jun 2020 10:44:10 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31dq2jbw81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 10:44:10 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 052EWj6U015700;
        Tue, 2 Jun 2020 10:44:09 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31dq2jbw73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 10:44:09 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 052EehHc010574;
        Tue, 2 Jun 2020 14:44:07 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04dal.us.ibm.com with ESMTP id 31bf4a15bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 14:44:07 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 052Eh6LO48300354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Jun 2020 14:43:06 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 532DB7805E;
        Tue,  2 Jun 2020 14:43:06 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30AEC78064;
        Tue,  2 Jun 2020 14:43:03 +0000 (GMT)
Received: from [153.66.254.194] (unknown [9.85.147.245])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  2 Jun 2020 14:43:02 +0000 (GMT)
Message-ID: <1591108981.4253.17.camel@linux.ibm.com>
Subject: Re: [PATCH v5 0/4] Introduce TEE based Trusted Keys support
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Sumit Garg <sumit.garg@linaro.org>,
        jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com
Cc:     dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org, tee-dev@lists.linaro.org
Date:   Tue, 02 Jun 2020 07:43:01 -0700
In-Reply-To: <1591107505-6030-1-git-send-email-sumit.garg@linaro.org>
References: <1591107505-6030-1-git-send-email-sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-02_13:2020-06-02,2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 cotscore=-2147483648 lowpriorityscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020104
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-06-02 at 19:48 +0530, Sumit Garg wrote:
> Add support for TEE based trusted keys where TEE provides the
> functionality to seal and unseal trusted keys using hardware unique
> key. Also, this is an alternative in case platform doesn't possess a
> TPM device.

So here's a meta problem: in the case when the platform possesses both
TEE and TPM  what should it do?  Things like this:

> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -25,6 +25,8 @@
>  
>  #if defined(CONFIG_TRUSTED_TPM)
>  static struct trusted_key_ops *trusted_key_ops =
> &tpm_trusted_key_ops;
> +#elif defined(CONFIG_TRUSTED_TEE)
> +static struct trusted_key_ops *trusted_key_ops =
> &tee_trusted_key_ops;
>  #else

Say it's either/or at a Kconfig level: so if you select both TEE and
TPM based trusted keys at compile time, we intall the TPM ops and
ignore the TEE ops, is that right?  Surely this should be runtime
selectable based on what the platform has ... perhaps it should even be
selectable per key?

Once it is runtime selectable, what should be selected in the both
case?  Or should we allow the user to decide, if so, how?

when you pipe a trusted key, I think the subtype (TEE or TPM) should be
part of the piped information, so it loads again seamlessly.  This
would actually be fixed by something like the ASN.1 scheme I'm trying
to upstream, at least for TPM keys, but do TEE keys have a recognized
ASN.1 format?

James

