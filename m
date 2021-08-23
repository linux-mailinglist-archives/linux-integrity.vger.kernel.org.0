Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7734C3F49AB
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Aug 2021 13:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbhHWLX4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Aug 2021 07:23:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235414AbhHWLX4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Aug 2021 07:23:56 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17NB3hWs059699;
        Mon, 23 Aug 2021 07:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=XNEd6K2ldu6BcLvbBhC4akja78OG+Or1y5NTDA4u4B0=;
 b=TzrfaGgADZl3C6ZUuyV+3qu6TlExN/PeiCAv/1g+wwTgtmCz2pqrMgdX/buJaOrTJUuD
 Y85J6qVi/BtqHCvVK0jtrg2tNIePXQhJlzLoEJMty0gi8XzTDu9X6JBiCNrBa35f3XK+
 N1S+dSbIN1ftKvHqxD1dr72L5Rwh/VcygsXxtjmWBt592OiKLWGPUVPv0oh5cvsyNDgk
 9hcT94gUMy5E6DJLhXcd+fZIA5EKCvNdwOCoSFnIb48h+8wT59jKOhE8mrRnykLxujVs
 CCJQJpgZNHIH8S/aOLy9kKP5YNxO18jU+L83tOKRhvuAYfKvLWTW9CdCXuUXjphIWZGO BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3akefyw193-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 07:23:02 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17NB3ss2060595;
        Mon, 23 Aug 2021 07:23:01 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3akefyw18e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 07:23:01 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17NBBNa0032706;
        Mon, 23 Aug 2021 11:22:59 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3ajs48u49c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 11:22:59 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17NBMuWT29164020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 11:22:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12499A4062;
        Mon, 23 Aug 2021 11:22:56 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28F32A406A;
        Mon, 23 Aug 2021 11:22:54 +0000 (GMT)
Received: from sig-9-65-215-209.ibm.com (unknown [9.65.215.209])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Aug 2021 11:22:53 +0000 (GMT)
Message-ID: <dc67b88df90ae037cb13d0ae4ba825ae891e5964.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: fix infinite loop within "ima_match_policy"
 function.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     =?UTF-8?Q?=E6=9D=8E=E5=8A=9B=E7=90=BC?= <liqiong@nfschina.com>,
        THOBY Simon <Simon.THOBY@viveris.fr>
Cc:     "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 23 Aug 2021 07:22:52 -0400
In-Reply-To: <f9798484-7090-0ddf-50a6-7c7c5bf0606c@nfschina.com>
References: <20210819101529.28001-1-liqiong@nfschina.com>
         <8d17f252-4a93-f430-3f25-e75556ab01e8@viveris.fr>
         <d385686b-ffa5-5794-2cf2-b87f2a471e78@nfschina.com>
         <1f631c3d-5dce-e477-bfb3-05aa38836442@viveris.fr>
         <96037695de6125c701889c168550def278adfd4b.camel@linux.ibm.com>
         <f9798484-7090-0ddf-50a6-7c7c5bf0606c@nfschina.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: g2p-jfAEwP1_o5IHdxq3PZExC3W0pgL0
X-Proofpoint-GUID: KMYptE5LDttQ0Zun41GftQCmHs3n4MpA
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-23_02:2021-08-23,2021-08-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 spamscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108230074
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Liqiong,

On Mon, 2021-08-23 at 11:04 +0800, 李力琼 wrote:
> Hi Mimi :
> 
> The situation is a little different,'list_splice_init_rcu'
> don't change the list head. If "ima_rules" being changed,
> readers may can't reload the new value in time for cpu cache
> or compiler optimization. Defining "ima_rules" as a volatile 
> variable can fix, but It is inefficient.

After looking at list_splice_tail_init_rcu() some more, it is
actually making sure there aren't any readers traversing
"ima_temp_rules", not "ima_policy_rules".   There aren't any readers
traversing "ima_temp_rules". 

> 
> Maybe using a temporary ima_rules variable for every 
> "list_for_each_entry_rcu(entry, ima_rules, list)" loop is 
> a better solution to fix the "endless loop" bug. 

Agreed

thanks,

Mimi


