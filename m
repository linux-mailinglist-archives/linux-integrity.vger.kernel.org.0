Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C86812EACB
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Jan 2020 21:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgABUK5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Jan 2020 15:10:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20346 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbgABUK5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Jan 2020 15:10:57 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 002K7UJS192316
        for <linux-integrity@vger.kernel.org>; Thu, 2 Jan 2020 15:10:56 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x62raxfc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 02 Jan 2020 15:10:56 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 002K5G2Q016189
        for <linux-integrity@vger.kernel.org>; Thu, 2 Jan 2020 20:10:55 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02wdc.us.ibm.com with ESMTP id 2x5xp6k8ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 02 Jan 2020 20:10:55 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 002KArMk49873196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Jan 2020 20:10:53 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8291DBE051;
        Thu,  2 Jan 2020 20:10:53 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 441ACBE04F;
        Thu,  2 Jan 2020 20:10:53 +0000 (GMT)
Received: from [9.2.202.58] (unknown [9.2.202.58])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  2 Jan 2020 20:10:53 +0000 (GMT)
To:     Linux Integrity <linux-integrity@vger.kernel.org>,
        Ken Goldman <kgoldman@us.ibm.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Subject: Spec needed for ima-modsig template
Message-ID: <e2e2863e-9908-5156-8aca-32f8e583f0e3@linux.ibm.com>
Date:   Thu, 2 Jan 2020 15:10:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-02_06:2020-01-02,2020-01-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 mlxlogscore=440
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001020161
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I'm trying to document the ima-modsig template and then write aparser. 
Can anyone help me complete it?

1 - What the implementation does today is interesting.  Even betterwould 
be what the implementation is permitted to do so that theparser will 
handle future changes.

2 - My understanding so far:

     ima-modsig        is        d-ng | n-ng | sig | d-modsig |modsig

     where (both have a prepended uint32_t length)

     d-modsig            is    d-ng, filedata hash, omitting the 
appended modsig signature
     modsig                is     pkcs7DER, appended signature

My immediate issue is that the d-modsig should be a length + 
hashalgorithm + file data hash.  However, the length in my sample log 
issometimes zero, which I did not expect.

I.e., it it legal for an ima-modsig template to contain an emptyd-modsig 
item?

Can the modsig item also be empty?
