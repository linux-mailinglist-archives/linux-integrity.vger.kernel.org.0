Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3289828F35E
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Oct 2020 15:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbgJONgr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Oct 2020 09:36:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3066 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729679AbgJONgr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Oct 2020 09:36:47 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09FDWwwW036086;
        Thu, 15 Oct 2020 09:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=hlCkMv6J8aF7eWzsCbE7T8d75Uoi7rDw65qi5aB3Flc=;
 b=EnP10peLDN8RtkEZERSLrAnmfrbQEnnhSG5btP8ETPPunTGCs3/jsmBWU/t/QMSWxtTc
 MjRZtKIkNTL4F8w8OM+t+G9S4BNEQ4Yog4zz86CyZvjDcgQM5kya1X0QjvG75m+pXlNJ
 56/XR6PGWfGorblnpAz8lSsRL/3AVRQLY7qgoj7A0dn2f6neqpKkPnsfSiujscQHI4z4
 GI5BU9EhZnjw2vf8AgMazkFGjUJBNQxCovLZPOOM95cd/uj7l+4s/8w04j9GGNm4eM4L
 /+2p+w55/mTzj5apriQz1DI+sq00fuF4dUdOcRdtKGwouKe+hiRt9NcVP5QkkyGgOLbY TQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 346q6g8mnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Oct 2020 09:36:44 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09FDW37a019085;
        Thu, 15 Oct 2020 13:36:41 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3434k7w9gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Oct 2020 13:36:41 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09FDadLr22806840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Oct 2020 13:36:39 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49F6FA4051;
        Thu, 15 Oct 2020 13:36:39 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 271BEA4055;
        Thu, 15 Oct 2020 13:36:38 +0000 (GMT)
Received: from sig-9-65-201-109.ibm.com (unknown [9.65.201.109])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 15 Oct 2020 13:36:37 +0000 (GMT)
Message-ID: <8d27071d0d4f72d99201e283b2840da53c2c3785.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/5] ima-evm-utils: Change env variable
 TPM_SERVER_TYPE for tpm_server
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ken Goldman <kgold@linux.ibm.com>,
        Ken Goldman <kgoldman@us.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>
Cc:     Petr Vorel <pvorel@suse.cz>
Date:   Thu, 15 Oct 2020 09:36:37 -0400
In-Reply-To: <7db39195-0e73-5958-03e3-7850bf5eb6b5@linux.ibm.com>
References: <20201012234416.20995-1-kgoldman@us.ibm.com>
         <20201012234416.20995-2-kgoldman@us.ibm.com>
         <ac8d885af1f79a8d1e2c137654b9924693b328b1.camel@linux.ibm.com>
         <fc912ea2-ef89-7fc4-8bf2-5f107b8cfc7e@linux.ibm.com>
         <a0060e2dd23281b1dbcc0d71f7615d46dd6f5aa7.camel@linux.ibm.com>
         <7db39195-0e73-5958-03e3-7850bf5eb6b5@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-15_08:2020-10-14,2020-10-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=3 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150096
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-10-15 at 08:54 -0400, Ken Goldman wrote:
> On 10/14/2020 6:28 PM, Mimi Zohar wrote:
> >>> Instead of adding a comment here, how about only exporting
> >>> TPM_SERVER_TYPE for "swtpm".
> 
> >> That certainly works.  I thought the idea was, "Make the
> >> smallest change that fixes the problem."   Moving that
> >> line under swtpm is a reasonable alternative.
> 
> > In this case, moving the line and adding the comment is the smallest
> > change.  To indicate this is a bug fix, you would add "Fixes:
> > f831508297cd ("Install the swtpm package, if available") in addition to
> > your Signed-off-by tag.
> > 
> 
> The current patch adds one line.  This proposal adds one line and
> moves another line.  It also changes the swtpm flow, which must
> be tested.
> 
> It's OK with me.  Let me know.
> 
> Where should I add that "Fixes ..." text?  What is the exact format?

The "Fixes" tag belongs in the patch description above your Signed-off-
by tag.  The format is:  Fixes: < commit number> < commit ttitle>

e.g. Fixes: f831508297cd ("Install the swtpm package, if available")

As this is a bug fix, please update the Subject line and post this
change independently of the other changes.  I've already tested the
suggested change.  Once the updated patch is posted, it will hopefully
be tested by the distros as well.

thanks,

Mimi

