Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0095570E83A
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 23:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjEWV6c (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 17:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238613AbjEWV6b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 17:58:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA434C2
        for <linux-integrity@vger.kernel.org>; Tue, 23 May 2023 14:58:29 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NLqGJQ008789
        for <linux-integrity@vger.kernel.org>; Tue, 23 May 2023 21:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date : to :
 from : subject : content-type : content-transfer-encoding : mime-version;
 s=pp1; bh=AmuK7tzN4GB2m/JhvIB2lrYYOxDHogWEzIc9f1w3/lI=;
 b=TeEV+U2uOahqHqzSr2boKWj0tX+DD+AMnoAmAWnGJvAINUEPlZqpvc4a9YDGHpmlmjk/
 223ywT/sSPeTzZ22QmwM8+fjSvrpD8PiGuJjCe+lGd1S/nH0Uo5fUF7I7sIGBAdPWCrK
 fVNqKH38wmwfZCbZTsHehQwjGGaHtL0m1dKEDr00EUhA67WYkdRMWBLYys+GlDVg+0e8
 Mz/JolIbf2QgRldyQPUb/mHn3uAR5711gTvvJYNe14CcbkDV+DzEP9vJfWx7Y7s9s6lB
 E14PaXK3De09gGdSsdulul3dT0F25lZaacxV+p3hieJTb0ribA52SFcBp/ceuTbFBt4z UQ== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qs5dx0gr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 23 May 2023 21:58:28 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34NKTfIw017999
        for <linux-integrity@vger.kernel.org>; Tue, 23 May 2023 21:58:27 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3qppdqh2d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 23 May 2023 21:58:27 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34NLwQko3539456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Tue, 23 May 2023 21:58:27 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F3545805A
        for <linux-integrity@vger.kernel.org>; Tue, 23 May 2023 21:58:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69F3E58054
        for <linux-integrity@vger.kernel.org>; Tue, 23 May 2023 21:58:26 +0000 (GMT)
Received: from [9.67.167.61] (unknown [9.67.167.61])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP
        for <linux-integrity@vger.kernel.org>; Tue, 23 May 2023 21:58:26 +0000 (GMT)
Message-ID: <4c4dae24-d367-699b-130b-4ac5b69c4597@linux.ibm.com>
Date:   Tue, 23 May 2023 17:58:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Linux Integrity <linux-integrity@vger.kernel.org>
From:   Ken Goldman <kgold@linux.ibm.com>
Subject: hash_info.h appreviations
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aapLmRnIzwZsQQe8ehyJ0BvsN0fRfbeZ
X-Proofpoint-GUID: aapLmRnIzwZsQQe8ehyJ0BvsN0fRfbeZ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_14,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=375 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230173
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/hash_info.h

I'm writing IMA documentation.  These enums appear in the IMA event log.

I suspect that WP is Whirlpool and TGR is Tiger?

Can you confirm?
