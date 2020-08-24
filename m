Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1742509D5
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Aug 2020 22:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgHXUNi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Aug 2020 16:13:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40798 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbgHXUNd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Aug 2020 16:13:33 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07OK5hcA109734
        for <linux-integrity@vger.kernel.org>; Mon, 24 Aug 2020 16:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=J9shjfh59k8x/JWzUouCS++inwrKhfKdSvldjmglypo=;
 b=BOalqv5vD6mHNieL8wzpKC19vdwH71oW2xm+4qPx77UwV2lCjZ2r4865exeHCtdlOHDw
 ZwCistopQ8zWXNy2aHagja5WCZvfjmA/jgv8kCWKfems/iP/cbJkiL+u7YgJHUx+N/ds
 P7WIFuFESD40gJkxcE6jfS9OnBST1LAHNbs3xADNym9TzDZsaR2A84QR7Q0BUARhYg5E
 u78y7spQl/0QT57Os70zF6iQZ+oTiSS8Ti3tpZIV6gF9FlgyUWekl7HE3/S/eTrEiJYU
 siJCCq1Zox96hAVMQUycs9WKv7e/JLhLr22hO6nVTpEWMFHj3dAHcWf0vuUHGoQmCfKY 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 334kvbgvwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 24 Aug 2020 16:13:32 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07OK6oDa113663
        for <linux-integrity@vger.kernel.org>; Mon, 24 Aug 2020 16:13:32 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 334kvbgvw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 16:13:32 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07OK705g003213;
        Mon, 24 Aug 2020 20:13:30 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 332utq1mq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 20:13:30 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07OKDSSx27459936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 20:13:28 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 004EC11C058;
        Mon, 24 Aug 2020 20:13:28 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C4DE11C054;
        Mon, 24 Aug 2020 20:13:27 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.122.56])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Aug 2020 20:13:26 +0000 (GMT)
Message-ID: <9a554241140d9807d61f802275b8af35d6f28ee9.camel@linux.ibm.com>
Subject: Re: [PATCH 4/4] integrity: prompt keyring name for unknown key
 request
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Bruno Meneguele <bmeneg@redhat.com>,
        linux-integrity@vger.kernel.org
Date:   Mon, 24 Aug 2020 16:13:26 -0400
In-Reply-To: <20200817215233.95319-5-bmeneg@redhat.com>
References: <20200817215233.95319-1-bmeneg@redhat.com>
         <20200817215233.95319-5-bmeneg@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008240155
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-08-17 at 18:52 -0300, Bruno Meneguele wrote:
> Depending on the IMA policy a key can be searched in multiple keyrings (e.g.
> .ima and .platform) and possibly failing for both. However, for the user not
> aware of the searching order it's not clear what's the keyring the kernel
> didn't find the key. With this patch we improve this feedback by printing
> the keyring "description" (name).
> 
> Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

