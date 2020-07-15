Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1DA2217CD
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jul 2020 00:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgGOWag (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 18:30:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726479AbgGOWag (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 18:30:36 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FM2dmF010488;
        Wed, 15 Jul 2020 18:30:32 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32991g5h8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 18:30:32 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06FMPFrw079074;
        Wed, 15 Jul 2020 18:30:32 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32991g5h7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 18:30:31 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06FMTcEn028873;
        Wed, 15 Jul 2020 22:30:29 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 327527w1u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 22:30:29 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06FMURCx2883868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 22:30:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 384034C044;
        Wed, 15 Jul 2020 22:30:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CF4F4C04E;
        Wed, 15 Jul 2020 22:30:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.155.184])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Jul 2020 22:30:26 +0000 (GMT)
Message-ID: <1594852226.12900.351.camel@linux.ibm.com>
Subject: Re: [PATCH 0/3] ima-evm-utils: miscellanous bug fixes
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Bruno Meneguele <bmeneg@redhat.com>,
        linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
Date:   Wed, 15 Jul 2020 18:30:26 -0400
In-Reply-To: <20200715213906.194041-1-bmeneg@redhat.com>
References: <20200715213906.194041-1-bmeneg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 spamscore=0 impostorscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150161
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-07-15 at 18:39 -0300, Bruno Meneguele wrote:
> While testing in RHEL7 the latest 'next-testing' branch changes the build
> failed due to an "out" label being placed at the end of the function
> calc_bootaggr() with no instructions for systems with OpenSSL version less
> then 1.1. Corrected it by putting a simple no-op 'return' there (the
> function returns nothing).
> 
> The other bugs are a simple memory leak, also on calc_bootaggr(), when
> _DigestUpdate() returns error; and an overflow while reading the
> boot_aggregate buffer due to the lack of the null char at the end.

Applied, thanks!

Mimi
