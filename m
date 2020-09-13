Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439C7267D38
	for <lists+linux-integrity@lfdr.de>; Sun, 13 Sep 2020 04:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgIMCJ6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 12 Sep 2020 22:09:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725906AbgIMCJ6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 12 Sep 2020 22:09:58 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08D213gZ044863;
        Sat, 12 Sep 2020 22:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=2lW71e6bymHVK3CImgyvBmZHszXBkKJ5j8o3dOv3h8M=;
 b=j57v4AxilN6Eh1h1fUhmHyAWmZGpgh16l76Gb42mvCpxTgrV8XAF8QRubvZc0oVjo/jH
 0rqonCG+5MT4r51xTD7+9PVeUwtDibny45qIPJYa3uBY9Qs7zgao1+ij5W0Wc6w5trux
 4qgLsk2bmCgqmqeR4NO9N3bcf9zApv7V6kkfoVz//d/p60kXF2tVIuxTdQa+7byDNRqq
 RHDP7YvxwQI1gVMNM1sGwz2Y6iq92qwVLt4Oyce+5D73nXQqAu1NJ8db0Ya53rxnInWS
 H2VZ4HLF6JyCspwzxJbr98WhJ0F13ts0alqYXCHz9Q/KWQisy+HlDp98naB1yhbDMdwf mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33h98397h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Sep 2020 22:09:55 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08D22Mac048433;
        Sat, 12 Sep 2020 22:09:55 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33h98397g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Sep 2020 22:09:55 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08D28f9L030950;
        Sun, 13 Sep 2020 02:09:53 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 33gny88wgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Sep 2020 02:09:53 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08D29psG37093882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Sep 2020 02:09:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51982A404D;
        Sun, 13 Sep 2020 02:09:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B679A4040;
        Sun, 13 Sep 2020 02:09:50 +0000 (GMT)
Received: from sig-9-65-251-134.ibm.com (unknown [9.65.251.134])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 13 Sep 2020 02:09:50 +0000 (GMT)
Message-ID: <b98f2daa47abe4b9568e70e429c68b6272a09b8f.camel@linux.ibm.com>
Subject: Re: Potential IMA Signing Bug
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Alexander Gaidis <alexander_gaidis@brown.edu>,
        linux-integrity@vger.kernel.org, dmitry.kasatkin@gmail.com
Date:   Sat, 12 Sep 2020 22:09:49 -0400
In-Reply-To: <726a6968-9829-18a5-4d3b-563b5dd02145@brown.edu>
References: <322722b2-4253-3069-4cbc-c15e5924f5fc@brown.edu>
         <7bc45e11c9af3fe65a08a379d7690866264a13e5.camel@linux.ibm.com>
         <726a6968-9829-18a5-4d3b-563b5dd02145@brown.edu>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-12_11:2020-09-10,2020-09-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0
 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009130010
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2020-09-12 at 16:19 -0600, Alexander Gaidis wrote:
> >> user@deb:~$ sudo dmesg | tail
> >> ...
> >> [   78.593140] integrity: no _ima keyring: -126
> >> [   78.593343] audit: type=1800 audit(1599673725.324:11): pid=582
> >> uid=1000 auid=1000 ses=1 subj==unconfined op=appraise_data
> >> cause=invalid-signature comm="bash" name="/home/user/hello" dev="sda1"
> >> ino=796088 res=0
> >> ```
> >>
> >> However, after running the file as root and switching back to my user
> >> profile I am able to run the file just fine due to the caching of the
> >> integrity status of the file.
> > 
> > For some reason as a user you can't access the _ima keyring -
> > "integrity: no _ima keyring: -126".   Please create an additional
> > signed file and try accessing that one as user, after accessing the
> > original signed one succeeds.
> > 
> 
> I could access the second file after running the first one as root. See
> below:

The next steps would be to determine if this bug has existed from the
beginning or was at some point introduced.  In the later case, you
would bisect the kernel based on good and bad starting points to
determine the commit that introduced the bug[1].

Mimi

[1] Documentation/admin-guide/bug-bisect.rst

