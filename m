Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99F331CA7D
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2019 16:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfENOhO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 May 2019 10:37:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45610 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726013AbfENOhO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 May 2019 10:37:14 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4EEXEsa086842
        for <linux-integrity@vger.kernel.org>; Tue, 14 May 2019 10:37:12 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sfwu3ndwr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 14 May 2019 10:37:12 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 14 May 2019 15:37:10 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 May 2019 15:37:07 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4EEb6ww27525286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 14:37:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53674A4051;
        Tue, 14 May 2019 14:37:06 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 597EFA4055;
        Tue, 14 May 2019 14:37:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.80.29])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 May 2019 14:37:05 +0000 (GMT)
Subject: Re: [PATCH 1/3 v5] add a new ima hook and policy to measure the
 cmdline
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     prakhar srivastava <prsriva02@gmail.com>
Cc:     linux-integrity@vger.kernel.org,
        inux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva@microsoft.com>
Date:   Tue, 14 May 2019 10:36:54 -0400
In-Reply-To: <CAEFn8qJNzG5scBcdVbrXpY7ZEbku+yNbMZn3M=JUW8nNZbGKoQ@mail.gmail.com>
References: <20190510223744.10154-1-prsriva02@gmail.com>
         <20190510223744.10154-2-prsriva02@gmail.com>
         <1557766592.4969.22.camel@linux.ibm.com>
         <CAEFn8qJNzG5scBcdVbrXpY7ZEbku+yNbMZn3M=JUW8nNZbGKoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19051414-0028-0000-0000-0000036D97EC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051414-0029-0000-0000-0000242D2A28
Message-Id: <1557844614.4139.47.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905140104
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> > > +{
> > > +
> > > +     if (action & IMA_MEASURE)
> > > +             ret = ima_store_template(entry, violation, NULL, buf, pcr);
> > > +
> > > +     if (action & IMA_AUDIT)
> > > +             ima_audit_measurement(iint, event_data.filename);
> >
> > The cover letter and patch description say this patch set is limited
> > to measuring the boot command line - IMA-measurement.
> >  ima_audit_measurement() adds file hashes in the audit log, which can
> > be used for security analytics and/or forensics.  This is part of IMA-
> > audit.  The call to ima_audit_measurement() is inappropriate.
> >
> To clarify, in one of the previous versions you mentioned it
> might be helpful to add audit.

The original question was whether the kexec command line should ONLY
be measured.  That decision impacts whether a new function
(process_buffer_measurement) is needed or whether you should still
call process_measurement().

> I might have misunderstood you, but i will remove the
> audit_measurement and make other corrections.
> Thankyou for your feedback.

Even if it was agreed that you were adding the ability to measure and
audit the kexec boot command line, the cover letter, the patch
descriptions and the patches themselves would need to reflect that.
 The call to ima_audit_measurement() would not be hidden like this,
but included as a separate patch.

Mimi




