Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D385977F8A3
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Aug 2023 16:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344411AbjHQOUT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Aug 2023 10:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbjHQOTr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Aug 2023 10:19:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864B42D78
        for <linux-integrity@vger.kernel.org>; Thu, 17 Aug 2023 07:19:45 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HECAxJ021809;
        Thu, 17 Aug 2023 14:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=DDJBMAAewgw0jl7C19nVMO9srRH6JCApmarSiZfjRpQ=;
 b=mSUcgreRMpDhv/L18WwpDj97Gz3lUUV4zfU/TLP6ifVhCpfw24h7VMDh3/CDHfc6XSuX
 EXgBMIWZLZD6OYkAzNkw9C5MreB2ypYFsUNNk0HYARO6dSw/DhXNtojoMSYoPQ77dsQ3
 eE0AUV36fA+7fORI3jYoo/6D9yOFHEFNPSGpdUF0kBFF5ia4z3AiZnWyTCc8QaZkr6w5
 URJ7AyqvksCDCVGGghEKSiYWr/hgtutqqBr4QgBIf3GcltU/preq9MFeBnONs38Z8bh8
 qCg7F6ClBF+DmzONdluqwy/X8eFh/22RTWJE6J02hz7xg9L3rN2zYFUgMv45AmIVpdtY +w== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3shn3sr7tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 14:19:36 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37HCpCHf001090;
        Thu, 17 Aug 2023 14:19:34 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3semsyq21r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 14:19:34 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37HEJY3R3080722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 14:19:34 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06A1C58060;
        Thu, 17 Aug 2023 14:19:34 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAC9A5805A;
        Thu, 17 Aug 2023 14:19:33 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.190.112])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 17 Aug 2023 14:19:33 +0000 (GMT)
Message-ID: <90b4b5573182ec68b2da2f9ef2bc6567d724f8f1.camel@linux.ibm.com>
Subject: Re: [RFC PATCH -next] ima: Make tpm hash configurable
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     GUO Zihua <guozihua@huawei.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-integrity@vger.kernel.org
Date:   Thu, 17 Aug 2023 10:19:33 -0400
In-Reply-To: <20230817061334.1910-1-guozihua@huawei.com>
References: <20230817061334.1910-1-guozihua@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -maM8Nr2_BqadvcaeMQDeoc0rWUqwvyT
X-Proofpoint-GUID: -maM8Nr2_BqadvcaeMQDeoc0rWUqwvyT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_08,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1011 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308170126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Scott,

This patch changes the TPM PCR hash algorithm and value in the IMA
measurement list.  The Subject line doesn't convey that.

On Thu, 2023-08-17 at 14:13 +0800, GUO Zihua wrote:
> TPM2 chips supports algorithms other than SHA1. However, the original
> IMA design hardcode template hash to be SHA1.

True, IMA initially calculated and extended a SHA1 hash into the TPM,
but Roberto addressed that years ago.  Refer to commit  1ea973df6e21
("ima: Calculate and extend PCR with digests in ima_template_entry").

IMA now calculates and extends each of the enabled TPM banks with the
appropriate hash value.  The PCR value in the IMA measurement list
remains SHA1.  Attestation servers can first verify the SHA1 template
hash as stored in the measurement list.  Then it can walk the IMA
measurement list calculating the template data hash based on the per
TPM bank algorithm to verify the TPM bank PCR value. 

> 
> This patch added CONFIG_IMA_TEMPLATE_HASH as well as ima_tpm_hash=
> cmdline argument for configurating template hash. The usage is simuliar
> to CONFIG_IMA_DEFAULT_HASH and ima_hash=. The configured hash is checked
> against TPM and make sure that the hash algorithm is supported by
> ima_tpm_chip.
> 
> To accommodate the change, we must put a digest length into binary
> measurement list items. The binary measurement list item format is
> changed to this:
> 	16bit-le=pcr#
> 	16bit-le=template digest size
> 	char[n]=template digest
> 	32bit-le=template name size
> 	char[n]=template name
> 	[eventdata length]
> 	eventdata[n]=template specific data
> The first element is now a 16bit pcr number and a 16bit template digest
> size, instead of the original 32bit pcr number.
> 
> The format of ascii_measurement_list is also changed. For sha1 template
> hash, the format is the same as before. For other hash algorithms, a
> hash name is prepended as such:
> "sha256:30ee3e25620478759600be00e06fda7b4fe23bbf575621d480400d536cf54f5b"
> Signed-off-by: GUO Zihua <guozihua@huawei.com>

Other proposals have changed the hard coded hash algorithm and PCR
value from SHA1 to SHA256.  Both that proposal and this will break
existing userspace applications.

Before we can introduce this sort of change, we would need to introduce
an IMA measurement list version.  Perhaps its time to define an IMA
security critical-data record, which would include this and other
information.  The measurement list itself would need to include a
version number.

-- 
thanks,

Mimi

