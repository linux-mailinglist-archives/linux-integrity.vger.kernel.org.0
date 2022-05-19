Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011DC52DEE3
	for <lists+linux-integrity@lfdr.de>; Thu, 19 May 2022 23:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiESVB5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 May 2022 17:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiESVB4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 May 2022 17:01:56 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CD8ED78C
        for <linux-integrity@vger.kernel.org>; Thu, 19 May 2022 14:01:52 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24JJHdDI022414
        for <linux-integrity@vger.kernel.org>; Thu, 19 May 2022 21:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=nkJRN0sS4oRt+CgqkA09CTJKWeo7lWCR6OFbXqhxMD8=;
 b=mi/TJEFw0wypgUT1psN/Bnsn20lyILIk/z28vWLOffYIKQGaPgI/z+ZCOOKZYcQj9mWk
 47zdjXc0Tlz8hr8SxDoVeBFsdTpZL/MC9d5ONJ7GQv0DKewgETu3jbqtnWy/inBkRw2C
 FTDw+LkqZ6oGnJjYA+sRlOJX02s8VE+F+mkODTP8ch0a07ICSL0KeXcU2yIC13RzfzcX
 wgCWIP+8FpxB3weQRSD2c72+Zl2sM5LR/dysQ+dVXTx1ZWK7YUM1IjyiSVo+0QNwtQAR
 ypmRoQ7FDldXY1/8ePyq1ljHV+tyF4/bxfO1zG5MOxxzWIOVporZ92frgmhaNlRasaxz 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g5ux2a06u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 19 May 2022 21:01:51 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24JKtYWW003992
        for <linux-integrity@vger.kernel.org>; Thu, 19 May 2022 21:01:50 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g5ux2a06m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 21:01:50 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24JKmoZI009668;
        Thu, 19 May 2022 21:01:50 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02wdc.us.ibm.com with ESMTP id 3g242a6ahe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 21:01:50 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24JL1n3Z6030278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 21:01:49 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C46C92805A;
        Thu, 19 May 2022 21:01:49 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68FF22805E;
        Thu, 19 May 2022 21:01:49 +0000 (GMT)
Received: from [9.211.155.3] (unknown [9.211.155.3])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 19 May 2022 21:01:49 +0000 (GMT)
Message-ID: <05559904-7fa9-bcaa-c5fe-b511b1d42d36@linux.ibm.com>
Date:   Thu, 19 May 2022 17:01:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Question on permissions of runtime and bios measurements files
Content-Language: en-US
To:     William Roberts <bill.c.roberts@gmail.com>,
        linux-integrity@vger.kernel.org
References: <CAFftDdrGYV=VwNPjypoOs1SmpNeZMTfrAFhht=zVOgC0hDrHSA@mail.gmail.com>
From:   Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <CAFftDdrGYV=VwNPjypoOs1SmpNeZMTfrAFhht=zVOgC0hDrHSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mLc9DT-mPQo2guCd6GJZNugv-zsEIQit
X-Proofpoint-ORIG-GUID: m6uPUsClM7X2VAtOQ8CXYMcq6Y3afrb-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-19_06,2022-05-19_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205190113
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/5/2022 9:59 AM, William Roberts wrote:
> Currently the tss command line tools can't access the system
> measurement logs for users even if they are in the group tss:
> 
> crw-rw---- 1 tss root 10, 224 Mai  3 17:22 /dev/tpm0
> -r--r----- 1 root root 0 Mai  3 17:22
> /sys/kernel/security/ima/binary_runtime_measurements
> -r--r----- 1 root root 0 Mai  3 17:22
> /sys/kernel/security/tpm0/binary_bios_measurements
> 
> So with tss2_quote, a quote can be computed but not the pcrLog for the
> system PCRs.
> The problem could be solved if the log files would be owned by tss.
> But that could create privacy issues because the pcrLog would e.g.
> contain executables in user home directories.
> Do you have any suggestions how the problem could be addressed?

If it were me, I'd change the group to tss.

The privacy issue doesn't bother me because

- the attestation program has to get the log in some way.
- typically, only root executed files are measured.
- it contains the hashes, not the executables.

keylime opens the file as root, keeps it open forever, and
then drops its privilege.
