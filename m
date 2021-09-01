Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887DE3FDE15
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Sep 2021 16:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhIAOz1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Sep 2021 10:55:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24592 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229748AbhIAOz0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Sep 2021 10:55:26 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 181EXPAI007427;
        Wed, 1 Sep 2021 10:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=9DZdRKzJEJ1kf7QtEQGQRIuTcNnizwB/HNlJ5GAj6ww=;
 b=JlS9mZ6ScCc/SDfi6jrR2PDGHZaPzaVpcb0waskknWbYlIeoqgdpQLt79KkZg8+xpWuc
 1wNQKY/vaBgDEcjRziwc/fQ/0wphvdryHuRfHuYYqHqUdd823hXl4irEWD63eRlUlRcL
 9iRJYvPtIa6g5TPtB4jKzO2Fn0k6SwsCx89ALDDuCO1zLmcdezl9FA7VU6IAh6BO3xHM
 ghTwQ1fKpGCNcMt2ANBfH7GY4iv3ambiT0q2aE21wknSOlppursyxuS0wmWDivsDhcKw
 WP+V2chbuhMG0y2qwCjBT++0mSbFpiEnUBTgHn06z/cIF9AR62XgFVYho6DOF9V3Cli1 qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3at7ybyb2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 10:54:29 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 181EgPii091184;
        Wed, 1 Sep 2021 10:54:29 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3at7ybyb1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 10:54:29 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 181EpxNU003327;
        Wed, 1 Sep 2021 14:54:26 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3aqcs9u0ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 14:54:26 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 181EoOrJ60555622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Sep 2021 14:50:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E0F642052;
        Wed,  1 Sep 2021 14:54:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A6F142045;
        Wed,  1 Sep 2021 14:54:23 +0000 (GMT)
Received: from sig-9-77-135-32.ibm.com (unknown [9.77.135.32])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Sep 2021 14:54:23 +0000 (GMT)
Message-ID: <ab00a38ebd268a67eae306a368cd94964a06f0ba.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: add gid support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Alex Henrie <alexh@vpitech.com>
Cc:     linux-integrity@vger.kernel.org, alexhenrie24@gmail.com
Date:   Wed, 01 Sep 2021 10:54:21 -0400
In-Reply-To: <20210831201241.a256fa28b510a8e2546be79a@vpitech.com>
References: <20210702222027.13973-1-alexh@vpitech.com>
         <20210831201241.a256fa28b510a8e2546be79a@vpitech.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ex9Iu4-HuU0uDwaN4aJcwLbTsqCytAcJ
X-Proofpoint-ORIG-GUID: 5KkvD0g_dTr34uz2y1i-ZvEe86LkaBID
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-01_04:2021-09-01,2021-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 clxscore=1011
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2109010085
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Alex,

On Tue, 2021-08-31 at 20:12 -0600, Alex Henrie wrote:
> Hello, could I get some feedback on this patch? Are there any
> objections to including it upstream?

Conceptually I don't have a problem with the patch, but I'd also like a
test to go with it.  

Roberto posted "ima-evm-utils: Add UML support and tests for EVM
portable signatures", which introduces using UML (User Mode Linux) for
testing new kernel features, which, unfortunately, still needs to be
reviewed and upstreamed.  (Hint, hint help with reviewing.]

Another option is to define an LTP test.   In either case, a custom IMA
policy would be defined in terms of a loopback mounted filesystem to
avoid affecting the entire system.

I'd appreciate your re-basing and re-posting this patch.

thanks,

Mimi

