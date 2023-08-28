Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F1678B999
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Aug 2023 22:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjH1UgD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Aug 2023 16:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbjH1Ufi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Aug 2023 16:35:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84A6109
        for <linux-integrity@vger.kernel.org>; Mon, 28 Aug 2023 13:35:35 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SKGfb9012906;
        Mon, 28 Aug 2023 20:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=D2ltVGkveRzgIOxe2vZWMfar/X9vBDb02Yuqkf3B3Tw=;
 b=kqBd0jmWNkqONTRUxoS1gReytRP7JYp+QSza1sQlrkYSx2Y1OFChdyUBq/+TNnXnL9gk
 W3Pyc49c1/gRuCyT90w43INAgY9fiBYjjiMyI3ThMSZA+PJNnwMHZyvth3awac6Rfu6f
 jXXT/v/wm3oeqNeEFhMfdEksYdedmix1Dr+9c8gqNHNFNHUD+HSVj5BLGStlU9PDD4PS
 FbcOon5MBgR4ItkZVWeJVR48gvgmL56kEXbGQF3JolTaSKqd4OvMT3FdpkL8Ea1iIQCp
 BLaMDSEPILhHZ8bTXz857kubJLyt34UywKaHT7gG4i5FISnVs4N4a8tQ7RE36FBUO4Vd 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr7vy9c36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 20:35:26 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37SKZA40001583;
        Mon, 28 Aug 2023 20:35:26 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr7vy9btt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 20:35:25 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37SJX45O020530;
        Mon, 28 Aug 2023 20:35:19 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqv3y6asb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 20:35:19 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37SKZJ4g60490212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 20:35:19 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AA9B5805D;
        Mon, 28 Aug 2023 20:35:19 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B25E758056;
        Mon, 28 Aug 2023 20:35:18 +0000 (GMT)
Received: from [9.67.181.110] (unknown [9.67.181.110])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 28 Aug 2023 20:35:18 +0000 (GMT)
Message-ID: <245b0517-4c13-2815-4b99-c3691f3b86eb@linux.ibm.com>
Date:   Mon, 28 Aug 2023 16:35:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH -next] ima: Make tpm hash configurable
Content-Language: en-US
To:     GUO Zihua <guozihua@huawei.com>, zohar@linux.ibm.com,
        corbet@lwn.net, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org
References: <20230817061334.1910-1-guozihua@huawei.com>
From:   Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <20230817061334.1910-1-guozihua@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v_5C8LWfnsPPFPi7OnR_-7CJwGilkraH
X-Proofpoint-GUID: COtEtD4unVMciPBoMSYzJJmoiwh8a1sq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_18,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=904
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308280178
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/17/2023 2:13 AM, GUO Zihua wrote:
> TPM2 chips supports algorithms other than SHA1. However, the original
> IMA design hardcode template hash to be SHA1.
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

I would not change the PCR handle to 16 bits.  The TPM supports NVRAM
based PCRs, and their handles would be 0x01xxxxxx. In the future, there
may be other 'first byte' values.

A template digest size does not describe the digest algorithm.  E.g.,
SM3 and SHA-256 are both 32 bytes.

If one wants to describe the digest algorithm in 2 bytes, a reasonable 
choice would be the values in the TCG Algorithm registry.  Se TPM Spec 
Part 2 Table 9 — Definition of (UINT16) TPM_ALG_ID Constants <IN/OUT, S>

E.g., SHA-256 is 000b and SM3 is 0012.

