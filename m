Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8452B2A450B
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Nov 2020 13:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgKCM0F (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Nov 2020 07:26:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728168AbgKCM0E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Nov 2020 07:26:04 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3C2GZq092419;
        Tue, 3 Nov 2020 07:26:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=mRDWfholXgQVY2y/aiRKFYk8NKIPeiRCHUtnSKceUOc=;
 b=MstBgu2sussRmhhbGxlmVcJojYSeSunWveLmw7mv51jRkUtfJoFitHvo1dwsLyaRlXKM
 VxNDD4UIhnb6aenxwi1IG4gsWiDjyjFtmarx/e6n/i6WLl6ztBTrmx23EF1jD5X2OH3/
 oSo5Z068XdjnlWmhxMuvUkp1ekx84ZgxmTwiB4jpRECQM9aKg0Rlzc8KAkfjKoy0h82m
 0Nir9uwtVTHcHF9IiQRrfrne2ZrWUppmbD2sBHFiFU/qRaz/P6dbYSEOhq/CCDv0lAs4
 HkT/Cb8rJImJmslMbRAQ9BWeAxoqivfd0tgLjbwKozFMXDSoC5vXECZx6LUvSIEWwOPz AA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34jwmh8cpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 07:26:01 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A3C4PsY104366;
        Tue, 3 Nov 2020 07:26:01 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34jwmh8cnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 07:26:00 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A3CE74G025823;
        Tue, 3 Nov 2020 12:25:58 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 34jbytrrp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 12:25:58 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A3CPubX3015340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Nov 2020 12:25:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40D5BAE045;
        Tue,  3 Nov 2020 12:25:56 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28F2DAE051;
        Tue,  3 Nov 2020 12:25:55 +0000 (GMT)
Received: from sig-9-65-255-16.ibm.com (unknown [9.65.255.16])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Nov 2020 12:25:55 +0000 (GMT)
Message-ID: <9bdf80cc1ab1c6344ff2cf88130aff3f87a7247b.camel@linux.ibm.com>
Subject: Re: [RFC] Finding the right target branch for patches that span IMA
 and SeLinux
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SELinux <selinux@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 03 Nov 2020 07:25:54 -0500
In-Reply-To: <CAHC9VhT36qSJvhH5CFwixdT8tzH2bqfvaDa6nPZt1rmOKOr_kQ@mail.gmail.com>
References: <703ced1a-3a48-f29e-9141-af78415d8402@linux.microsoft.com>
         <f99f0f03aecc778826d79eb83d60cfd1a95196c5.camel@linux.ibm.com>
         <2ea3d341-6299-ec40-b553-f9f59a36cfb3@linux.microsoft.com>
         <CAHC9VhR8mbqZS3TVgG7MxQywe9uqDRCN+c59PozLTpOoQ-mK7Q@mail.gmail.com>
         <9195fd7a-a5c5-8588-d33c-772d2f530032@linux.microsoft.com>
         <CAHC9VhT36qSJvhH5CFwixdT8tzH2bqfvaDa6nPZt1rmOKOr_kQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_07:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=3
 adultscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030079
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-11-02 at 22:11 -0500, Paul Moore wrote:
> On Sat, Oct 31, 2020 at 11:08 PM Tushar Sugandhi
> 
> Can you and Lakshmi help me better understand the state of the
> SELinux/IMA patches?  I see that you included Lakshmi's SELinux/IMA
> patch in your last patchset, and it appears to have included feedback
> from Stephen's last review.  Is it your intent to continue to submit
> the SELinux/IMA patch as part of a larger patchset, or do you plan to
> split that back out into a standalone patch?

Paul,  I've asked Tushar and Lakshmi to first define "critical data"
and then include at least one example of measuring "critical data" to
simplify review.  As the SELinux patch is the first example, there is a
dependency on the rest of the patch set.

thanks,

Mimi

