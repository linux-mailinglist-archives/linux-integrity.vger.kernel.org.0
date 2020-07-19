Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FAF225177
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Jul 2020 13:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgGSLCr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 19 Jul 2020 07:02:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725988AbgGSLCr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 19 Jul 2020 07:02:47 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06JB2W16014314;
        Sun, 19 Jul 2020 07:02:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32bw7y757y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Jul 2020 07:02:34 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06JB2YWp014459;
        Sun, 19 Jul 2020 07:02:34 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32bw7y752t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Jul 2020 07:02:34 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06JB0ZJ2021800;
        Sun, 19 Jul 2020 11:02:11 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 32brq80mhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Jul 2020 11:02:10 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06JB28MX29557122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Jul 2020 11:02:08 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 789F6A4051;
        Sun, 19 Jul 2020 11:02:08 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22C19A405D;
        Sun, 19 Jul 2020 11:02:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.150.54])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 19 Jul 2020 11:02:07 +0000 (GMT)
Message-ID: <1595156526.27397.67.camel@linux.ibm.com>
Subject: Re: [PATCH v3 01/12] ima: Have the LSM free its audit rule
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Nayna <nayna@linux.vnet.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Date:   Sun, 19 Jul 2020 07:02:06 -0400
In-Reply-To: <20200717192447.GO3673@sequoia>
References: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
         <20200709061911.954326-2-tyhicks@linux.microsoft.com>
         <5ee27a51-7ff9-5763-c85f-e99e62458657@linux.vnet.ibm.com>
         <20200717192447.GO3673@sequoia>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-19_01:2020-07-17,2020-07-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007190080
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-07-17 at 14:24 -0500, Tyler Hicks wrote:
> On 2020-07-17 15:20:22, Nayna wrote:
> > 
> > On 7/9/20 2:19 AM, Tyler Hicks wrote:
> > > Ask the LSM to free its audit rule rather than directly calling kfree().
> > 
> > Is it to be called audit rule or filter rule ?  Likewise in subject line.
> gt
> The security hooks call this "audit rule" but Mimi explained the
> reasoning for IMA referring to this as an "audit filter" here:
> 
>  https://lore.kernel.org/lkml/1593466203.5085.62.camel@linux.ibm.com/
> 
> I would be fine with her renaming/rewording this patch, accordingly, in
> next-integrity-testing.

Both here and "ima: AppArmor satisfies the audit rule requirements",
the subject is AppArmor/LSM, which do refer to the rules as "audit"
rules.  In the "ima: Rename internal audit rule functions" case, the
rule rename is internal to IMA.  Here it makes sense to replace
"audit" with "filter".  Tyler, I've gone ahead and made the change.

Mimi

