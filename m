Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A4040000D
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Sep 2021 14:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349240AbhICM4g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Sep 2021 08:56:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235211AbhICM4f (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Sep 2021 08:56:35 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 183CsFpl085296
        for <linux-integrity@vger.kernel.org>; Fri, 3 Sep 2021 08:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=Q+1UziaL+KoD2Ztx2hNmMAr6L2fl6afI06GpwUxYb6A=;
 b=KXeJgMGgeS+yvRtkpCt0tQk08IOhLL01OE1zusrhnOTcSL+WEfHh8CDsuTnVbVsv5WIb
 n50DKBtNkrhAy4niOg8fRgNvkaXXM13hCtqgKlBMgouyhinf2g573MkAuE9w2OOpRQBM
 B8LWCBJsKyD9VCvhVBZY1nBMgcKchNg7pEMcgl/zceRc1DAm+y+AszaIzkMBvBIMdEkV
 COIqU9eswQY3A0xWVWKYFd+dPOCEKa6KucGsUCvuFJBeV4jfdCd+7inna/MrhJUfjV+Q
 /qB4WFmg/Q3+UQAGP6iL8kiUcYDO8V//YvWjKf330hRfbfvpSizZ1O/4jv+v60abXEUa pw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3auj0wu7us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Sep 2021 08:55:35 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 183Cl272027874
        for <linux-integrity@vger.kernel.org>; Fri, 3 Sep 2021 12:55:33 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3au6pn07m8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Sep 2021 12:55:33 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 183CtUnv29163930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Sep 2021 12:55:30 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 144354C070;
        Fri,  3 Sep 2021 12:55:30 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 775414C063;
        Fri,  3 Sep 2021 12:55:29 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.38.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Sep 2021 12:55:29 +0000 (GMT)
Message-ID: <305de114c3272506c1b6e31706d730d186812aac.camel@linux.ibm.com>
Subject: Re: [PATCH v2 6/8] libimaevm: Add support for pkcs11 private keys
 for signing a v2 hash
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Date:   Fri, 03 Sep 2021 08:55:28 -0400
In-Reply-To: <20210810134557.2444863-7-stefanb@linux.vnet.ibm.com>
References: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
         <20210810134557.2444863-7-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VxMcYWB7zp6HDwoTWYiILjOLFgDcqA0I
X-Proofpoint-ORIG-GUID: VxMcYWB7zp6HDwoTWYiILjOLFgDcqA0I
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-03_03:2021-09-03,2021-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109030077
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

Perhaps reword the subject line as, "libimaevm: add pkcs11 private key
support for signing a v2 hash".

On Tue, 2021-08-10 at 09:45 -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Add support for pkcs11 private keys for signing a v2 hash.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

thanks,

Mimi

