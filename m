Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320BD40FF1C
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Sep 2021 20:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbhIQSX7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Sep 2021 14:23:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230465AbhIQSX6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Sep 2021 14:23:58 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18HHTmN4018805
        for <linux-integrity@vger.kernel.org>; Fri, 17 Sep 2021 14:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : content-type : mime-version :
 content-transfer-encoding; s=pp1;
 bh=V9rQTS71/yj1pBWLPvMGSUN61uR40sWyLmPPv0iALKo=;
 b=G+9gBwh+RI8UitqzjNJBv2clxEUGb5Zxl2/4zeMqv4JswB14yDqE86dTJ1bX8qxDq1Bo
 V9GoNuN/j+Njw5RK0gDzVgllFzqUug5mEOfqUAFrXqu/MtVSs+hiIorp0u0+oOMUN/E6
 FhD3g8v62NZXbLBMIw+tk6YmPy3vN0YPqYax1LqeYVvf76u3YufX+d9SvUVl+ZZIgHzN
 89L0dcwNPmXjcxGa2MvIMnkBBQcgxolppfNTUWm70Q7GQJh10rOR3K+LbkIqwcLg8Bnz
 VnT2/WPGdAZGZGniZMPB1V7nraCPnQdRwaxT+5SxbsDjZxdStWyuYGnt09SoMSzdd9kb CA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b4huk4jha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 17 Sep 2021 14:22:36 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18HII21a023893
        for <linux-integrity@vger.kernel.org>; Fri, 17 Sep 2021 18:22:33 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3b0m3aya5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 17 Sep 2021 18:22:33 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18HIMV2U34472396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Fri, 17 Sep 2021 18:22:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51035A4051
        for <linux-integrity@vger.kernel.org>; Fri, 17 Sep 2021 18:22:31 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4E12A4055
        for <linux-integrity@vger.kernel.org>; Fri, 17 Sep 2021 18:22:30 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.166.232])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP
        for <linux-integrity@vger.kernel.org>; Fri, 17 Sep 2021 18:22:30 +0000 (GMT)
Message-ID: <3fd81e923d39f18db49c0d3f9302899d0b01664a.camel@linux.ibm.com>
Subject: Vacation: weeks 20 and 27
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>
Date:   Fri, 17 Sep 2021 14:22:30 -0400
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gsUGBkYBcpxAWf875u8Fs1bE_UXOB4xw
X-Proofpoint-GUID: gsUGBkYBcpxAWf875u8Fs1bE_UXOB4xw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-17_07,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=537 mlxscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109170109
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I'll be on vacation the next two weeks with intermittent internet
access.   Please expect slow response.

thanks,

Mimi

