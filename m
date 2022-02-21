Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F9C4BD4F4
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Feb 2022 06:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239555AbiBUFME (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Feb 2022 00:12:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbiBUFMD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Feb 2022 00:12:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC08F6B;
        Sun, 20 Feb 2022 21:11:41 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21L1kmvN001742;
        Mon, 21 Feb 2022 05:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=rqbJNB7ceD4txv7qnU3G/TJ1EzAn3nFOxrgn4mCRPGc=;
 b=ZqwdyjD94OdR8BgAYlFWq1eSxIuXO0wASenp63pRUgQKIe/bckIvYUUIkNXfZwLZqHwH
 fgaQsEkELMpVcTFxMDc7FJo1h3WbTmNiXlJdtlIjW68Ex5yHi4480v54y1IOXOR8Y1eG
 9QxJSu3uZ2ZxP75bKASIJWNhYhVADOcprhvz5yCgASEhrjRVV4qgcDcDAaLEpkyVf+BS
 0MSaG0C6JJBmNwzi5+8FSaZW690YZ+EqSwuxA2fgzH3MkHxHqA65AbozV+/q+KkC7x3k
 8A8rCE+gDU4EHjiQk3H0XeMosF6u9hwBvFhRavGRnk/lqY6+gkvgxNpHLtPdCkwVJcu0 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ec1cg2y9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 05:11:30 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21L50gMA021650;
        Mon, 21 Feb 2022 05:11:29 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ec1cg2y96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 05:11:29 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21L58iRd022268;
        Mon, 21 Feb 2022 05:11:27 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3eaqthqk1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 05:11:26 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21L5BOUh46137842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 05:11:24 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73635A4060;
        Mon, 21 Feb 2022 05:11:24 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2C69A4068;
        Mon, 21 Feb 2022 05:11:22 +0000 (GMT)
Received: from sig-9-65-90-122.ibm.com (unknown [9.65.90.122])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Feb 2022 05:11:22 +0000 (GMT)
Message-ID: <0aa47dfaada88f1cbd2162784f8b77f43566f626.camel@linux.ibm.com>
Subject: Re: [PATCH v5] KEYS: encrypted: Instantiate key with user-provided
 decrypted data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Yael Tzur <yaelt@google.com>, linux-integrity@vger.kernel.org
Cc:     jejb@linux.ibm.com, jarkko@kernel.org, corbet@lwn.net,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Date:   Mon, 21 Feb 2022 00:11:22 -0500
In-Reply-To: <20220215141953.1557009-1-yaelt@google.com>
References: <20220215141953.1557009-1-yaelt@google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: quEvIySwxJvuMedB1D2tQxa0Xugn-c18
X-Proofpoint-ORIG-GUID: WSVVINvjQg7GWnsAM8VKvAxTPwoqnsM8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-21_01,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202210031
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-02-15 at 09:19 -0500, Yael Tzur wrote:
> For availability and performance reasons master keys often need to be
> released outside of a Key Management Service (KMS) to clients. It
> would be beneficial to provide a mechanism where the
> wrapping/unwrapping of data encryption keys (DEKs) is not dependent
> on a remote call at runtime yet security is not (or only minimally)
> compromised. Master keys could be securely stored in the Kernel and
> be used to wrap/unwrap keys from Userspace.
> 
> The encrypted.c class supports instantiation of encrypted keys with
> either an already-encrypted key material, or by generating new key
> material based on random numbers. This patch defines a new datablob
> format: [<format>] <master-key name> <decrypted data length>
> <decrypted data> that allows to inject and encrypt user-provided
> decrypted data. The decrypted data must be hex-ascii encoded.
> 
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Yael Tzur <yaelt@google.com>

Thanks,  Yael.

This patch is now queued in the #next-integrity-testing branch.

-- 
thanks,

Mimi

