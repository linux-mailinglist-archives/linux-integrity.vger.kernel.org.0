Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED361F41EA
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jun 2020 19:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbgFIRPI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Jun 2020 13:15:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729795AbgFIRPH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Jun 2020 13:15:07 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 059H1kxt065235;
        Tue, 9 Jun 2020 13:15:05 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31gg821tdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 13:15:04 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 059H1wwZ065954;
        Tue, 9 Jun 2020 13:15:02 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31gg821tc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 13:15:02 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 059HBROl027618;
        Tue, 9 Jun 2020 17:14:59 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 31g2s7tktt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 17:14:59 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 059HEvsT57082040
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Jun 2020 17:14:57 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8828F42041;
        Tue,  9 Jun 2020 17:14:57 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7EC54203F;
        Tue,  9 Jun 2020 17:14:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.146.136])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Jun 2020 17:14:56 +0000 (GMT)
Message-ID: <1591722896.5567.31.camel@linux.ibm.com>
Subject: Re: [PATCH v3] IMA: Add audit log for failure conditions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Steve Grubb <sgrubb@redhat.com>
Cc:     linux-audit@redhat.com, paul@paul-moore.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Jun 2020 13:14:56 -0400
In-Reply-To: <518a51b7-6c8d-f55f-c73a-b15abae8e0af@linux.microsoft.com>
References: <20200608215343.4491-1-nramas@linux.microsoft.com>
         <27448076.Og45N0Lxmj@x2>
         <ada45440-aefd-a4b2-2a3b-c012872e86cb@linux.microsoft.com>
         <3776526.Vj75JV9fuy@x2>
         <518a51b7-6c8d-f55f-c73a-b15abae8e0af@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-09_10:2020-06-09,2020-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006090126
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-06-09 at 10:00 -0700, Lakshmi Ramasubramanian wrote:
> On 6/9/20 9:43 AM, Steve Grubb wrote:
> 
> >> The number in parenthesis is the error code (such as ENOMEM, EINVAL,
> >> etc.) IMA uses this format for reporting TPM errors in one of the audit
> >> messages (In ima_add_template_entry()). I followed the same pattern.
> >>
> >> Would it be better if the value for "cause" is formatted as
> >>
> >>      cause=hashing_error_-22
> >>
> >>      cause=alloc_entry_-12
> > 
> > Neither fit the name=value style that all other events follow. What would fit
> > the style is something like this:
> > 
> > cause=hashing_error  errno=-22
> >   
> > cause=alloc_entry errno=-12
> > 
> > Would this be OK? Also, errno is only to illustrate. You can name it
> > something else as long as there are no use case collisions with our
> > dictionary of field names.
> > 
> > https://github.com/linux-audit/audit-documentation/blob/master/specs/fields/
> > field-dictionary.csv
> 
> I am fine with this.
> 
> "errno" is currently not listed in the dictionary of audit message field 
> names (Thanks for the pointer to this one Steve)
> 
> Mimi - please let me know if you have any concerns with adding the 
> "result" code in "errno" field in integrity_audit_msg().
> 
> Sample message:
> 
> [    8.051937] audit: type=1804 audit(1591633422.365:8): pid=1 uid=0 
> auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 
> op=measuring_keys cause=hashing_error errno=-22 comm="systemd" 
> name=".builtin_trusted_keys" res=0

Yes, that's fine.

Mimi
