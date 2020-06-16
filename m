Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0B11FBF72
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 21:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbgFPTxt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 15:53:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16852 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728144AbgFPTxs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 15:53:48 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05GJW5fa008713;
        Tue, 16 Jun 2020 15:53:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31q1b1e3se-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 15:53:46 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05GJohqH075593;
        Tue, 16 Jun 2020 15:53:46 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31q1b1e3rx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 15:53:46 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05GJnhjp013450;
        Tue, 16 Jun 2020 19:53:44 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 31mpe7wvcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 19:53:43 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05GJrfI04063548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jun 2020 19:53:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA93E4203F;
        Tue, 16 Jun 2020 19:53:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C880642045;
        Tue, 16 Jun 2020 19:53:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.158.198])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 16 Jun 2020 19:53:40 +0000 (GMT)
Message-ID: <1592337220.11061.239.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] integrity: Add errno field in audit message
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Steve Grubb <sgrubb@redhat.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Paul Moore <paul@paul-moore.com>, rgb@redhat.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Jun 2020 15:53:40 -0400
In-Reply-To: <1717101.NiBDiG0Zly@x2>
References: <20200611000400.3771-1-nramas@linux.microsoft.com>
         <6643272.rC52FQZPYE@x2>
         <958966b6-9972-051f-a7d5-cd6d1beb3244@linux.microsoft.com>
         <1717101.NiBDiG0Zly@x2>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-16_11:2020-06-16,2020-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 cotscore=-2147483648 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006160134
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-06-16 at 11:55 -0400, Steve Grubb wrote:
> On Tuesday, June 16, 2020 11:43:31 AM EDT Lakshmi Ramasubramanian wrote:
> > On 6/16/20 8:29 AM, Steve Grubb wrote:
> > >>>>> The idea is a good idea, but you're assuming that "result" is always
> > >>>>> errno.  That was probably true originally, but isn't now.  For
> > >>>>> example, ima_appraise_measurement() calls xattr_verify(), which
> > >>>>> compares the security.ima hash with the calculated file hash.  On
> > >>>>> failure, it returns the result of memcmp().  Each and every code path
> > >>>>> will need to be checked.
> > >>>> 
> > >>>> Good catch Mimi.
> > >>>> 
> > >>>> Instead of "errno" should we just use "result" and log the value given
> > >>>> in the result parameter?
> > >>> 
> > >>> That would likely collide with another field of the same name which is
> > >>> the
> > >>> operation's results. If it really is errno, the name is fine. It's
> > >>> generic
> > >>> enough that it can be reused on other events if that mattered.
> > >> 
> > >> Steve, what is the historical reason why we have both "res" and
> > >> "result" for indicating a boolean success/fail?  I'm just curious how
> > >> we ended up this way, and who may still be using "result".
> > > 
> > > I think its pam and some other user space things did this. But because of
> > > mixed machines in datacenters supporting multiple versions of OS, we have
> > > to leave result alone. It has to be 0,1 or success/fail. We cannot use
> > > it for errno.
> > 
> > As Mimi had pointed out, since the value passed in result parameter is
> > not always an error code, "errno" is not an appropriate name.
> > 
> > Can we add a new field, say, "op_result" to report the result of the
> > specified operation?
> 
> Sure. But since it is errno sometimes, how would we know when to translate 
> it?

Perhaps the solution is not to imply "res" is "errno", but pass it as
a separate "errno" field.  Then only include "errno" in the audit
message when it isn't zero.  This assumes that some audit messages for
the same audit number include errno, while others do not.

With this solution, the existing integrity_audit_msg() could become a
wrapper for the new function.

Mimi
