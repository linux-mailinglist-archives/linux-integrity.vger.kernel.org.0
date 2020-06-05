Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E354F1F01D2
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jun 2020 23:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgFEVen (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jun 2020 17:34:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728323AbgFEVem (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jun 2020 17:34:42 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 055LWl6m155451;
        Fri, 5 Jun 2020 17:34:40 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31fr7rta5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 17:34:40 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 055LWs8r156433;
        Fri, 5 Jun 2020 17:34:39 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31fr7rta52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 17:34:39 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 055LGgRe006768;
        Fri, 5 Jun 2020 21:34:37 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 31bf484xr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 21:34:37 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 055LYZij65536072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Jun 2020 21:34:35 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F38F8AE045;
        Fri,  5 Jun 2020 21:34:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11EE5AE055;
        Fri,  5 Jun 2020 21:34:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.234.64])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  5 Jun 2020 21:34:33 +0000 (GMT)
Message-ID: <1591392867.4615.20.camel@linux.ibm.com>
Subject: Re: [PATCH] IMA: Add log statements for failure conditions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-integrity@vger.kernel.org, tusharsu@linux.microsoft.com,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com
Date:   Fri, 05 Jun 2020 17:34:27 -0400
In-Reply-To: <48ff60f1-df93-5ce7-a254-8bfd1dba2ade@linux.microsoft.com>
References: <20200604163243.2575-1-nramas@linux.microsoft.com>
         <1591382782.5816.36.camel@linux.ibm.com>
         <CAHC9VhS-EP=Kk3GKRzAGAYa5mqupkLQCHz_m_DgoAKRWcSTgLA@mail.gmail.com>
         <8dfb3fa6-5c1f-d644-7d21-72a9448c52cc@linux.microsoft.com>
         <CAHC9VhS8gmrWxt75aHAE16PWAay7sUrffZiT0A8VLugwexK4Uw@mail.gmail.com>
         <48ff60f1-df93-5ce7-a254-8bfd1dba2ade@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-05_07:2020-06-04,2020-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 bulkscore=0 cotscore=-2147483648 suspectscore=0
 spamscore=0 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006050157
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-06-05 at 14:09 -0700, Lakshmi Ramasubramanian wrote:
> On 6/5/20 1:49 PM, Paul Moore wrote:
> 
> > 
> >> Since a pr_xyz() call was already present, I just wanted to change the
> >> log level to keep the code change to the minimum. But if audit log is
> >> the right approach for this case, I'll update.
> > 
> > Generally we reserve audit for things that are required for various
> > security certifications and/or "security relevant".  From what you
> > mentioned above, it seems like this would fall into the second
> > category if not the first.
> > 
> > Looking at your patch it doesn't look like you are trying to record
> > anything special so you may be able to use the existing
> > integrity_audit_msg(...) helper.  Of course then the question comes
> > down to the audit record type (the audit_msgno argument), the
> > operation (op), and the comm/cause (cause).
> > 
> > Do you feel that any of the existing audit record types are a good fit for this?
> > 
> 
> Maybe I can use the audit_msgno "AUDIT_INTEGRITY_PCR" with appropriate 
> strings for "op" and "cause".
> 
> Mimi - please let me know if you think this audit_msgno would be ok to 
> use. I see this code used, for instance, for boot aggregate measurement.
> 
> integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, boot_aggregate_name, op,
> 		    audit_cause, result, 0);

Yes, AUDIT_INTEGRITY_PCR is also used for failures to add to the
measurement list.

thanks,

Mimi
