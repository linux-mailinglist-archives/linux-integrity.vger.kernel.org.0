Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA32B6EF63B
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Apr 2023 16:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241321AbjDZOUf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Apr 2023 10:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241292AbjDZOUe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Apr 2023 10:20:34 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334867696
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 07:20:19 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QE8TDb028683;
        Wed, 26 Apr 2023 14:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=U6Endoyt9hK00ZiN62tKyDkBOLOVU4z3gNUJM6VdV0w=;
 b=AUpxeMn4AW7LZ/sjwC97uAiksfc6Yvquw9BOHBYg3+ZGAXehhPaOazaPWYwdXVgdgW0Q
 vMe4l2viqLryhx7KrA1n6+oobN+ZQ52A+Q0/1hJxDwEbUun62AQ1gEo/90nFns5C7AwG
 MHCKIo9D8EPjo5CyQvPHDNvXF/5rP/Y0axvCSh1gFHSTxRkuUKOCvpVOldj/ZbIDwEjk
 VnoTvRTKYl3mMxaM9hcNR2OIOAVSaOIHD9aj4wELHY76uDk9E7xVVC/CratUKdZtfJaT
 F8NRutecnlwGPl2tHzNipQ3ylSGZUcMOMVXlYRHk2rgzEYlWgvTWe1w85r2OpPaZW9vW 2Q== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q74sy1yk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 14:20:16 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33QCT6L9009642;
        Wed, 26 Apr 2023 14:20:15 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3q477933e6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 14:20:15 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33QEKEld38601226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 14:20:14 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26F935805D;
        Wed, 26 Apr 2023 14:20:14 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98D2258062;
        Wed, 26 Apr 2023 14:20:13 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 26 Apr 2023 14:20:13 +0000 (GMT)
Message-ID: <8c84360c-285a-7492-275a-5552580b8535@linux.ibm.com>
Date:   Wed, 26 Apr 2023 10:20:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH ima-evm-utils v2 2/2] examples: Add examples for elliptic
 curve key and certs generation
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Eric Snowberg <eric.snowberg@oracle.com>
References: <20230425161015.593988-1-stefanb@linux.ibm.com>
 <20230425161015.593988-3-stefanb@linux.ibm.com>
 <19fb6105c7343810a879a52421d847ab665bd8e9.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <19fb6105c7343810a879a52421d847ab665bd8e9.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TTbaDwvGe3cGq_JGOsw302pM6yjQ4TmD
X-Proofpoint-GUID: TTbaDwvGe3cGq_JGOsw302pM6yjQ4TmD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_06,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=985
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 spamscore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304260125
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 4/26/23 09:58, Mimi Zohar wrote:

> In preparation to allowing only code signing keys on the IMA keyring,
> please add "extendedKeyUsage=critical,codeSigning",
> 
>> +subjectKeyIdentifier=hash
>> +authorityKeyIdentifier=keyid
>> +#authorityKeyIdentifier=keyid,issuer
>> +__EOF__
>> +
>> +openssl req -new -nodes -utf8 -sha1 -days 365 -batch -config $GENKEY \
> 
> And similarly change sha1 to sha256 here.

Should we make all these changes first to the existing scripts for RSA keys?
