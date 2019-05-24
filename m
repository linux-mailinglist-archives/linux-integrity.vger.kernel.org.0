Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6A6B29EEA
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2019 21:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfEXTPj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 May 2019 15:15:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729017AbfEXTPj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 May 2019 15:15:39 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4OJCC6r002926
        for <linux-integrity@vger.kernel.org>; Fri, 24 May 2019 15:15:38 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sppea8gs8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 24 May 2019 15:15:38 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 24 May 2019 20:15:36 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 May 2019 20:15:33 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4OJFWsn43515912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 19:15:32 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 284ED68129;
        Fri, 24 May 2019 19:15:32 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42BD16811F;
        Fri, 24 May 2019 19:15:31 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 24 May 2019 19:15:31 +0000 (GMT)
Subject: Re: Re:
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     prakhar srivastava <prsriva02@gmail.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        vgoyal@redhat.com
Date:   Fri, 24 May 2019 15:15:30 -0400
In-Reply-To: <CAEFn8q+8QUs8iCP+Q3VujTkTU+XYYPGY8O8+KT1=6vvc-khJFg@mail.gmail.com>
References: <20190521000645.16227-1-prsriva02@gmail.com>
         <20190521000645.16227-3-prsriva02@gmail.com>
         <1558710722.3977.68.camel@linux.ibm.com>
         <a7acac28-156e-80d1-b759-cb0c59f73169@huawei.com>
         <cb0eb785-9050-738e-c1bf-8e769fe096fa@huawei.com>
         <1558721385.3977.84.camel@linux.ibm.com>
         <CAEFn8q+8QUs8iCP+Q3VujTkTU+XYYPGY8O8+KT1=6vvc-khJFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19052419-0016-0000-0000-0000027F1FBC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052419-0017-0000-0000-000032DC1DE6
Message-Id: <1558725330.3977.119.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905240124
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-05-24 at 12:00 -0700, prakhar srivastava wrote:
> On Fri, May 24, 2019 at 11:09 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > > >> As mentioned, the first patch description should include a shell
> > > >> command for verifying the digest in the kexec boot command line
> > > >> measurement list record against /proc/cmdline.  This patch description
> > > >> should include a shell command showing how to verify the digest based
> > > >> on the new field.  Should the new field in the ascii measurement list
> > > >> be displayed as a string, not hex?
> > > >
> > > > We should define a new type. If the type is DATA_FMT_STRING, spaces are
> > > > replaced with '_'.
> > >
> > > Or better. Leave it as hex, otherwise there would be a parsing problem
> > > if there are spaces in the data for a field.
> >
> > After making a few changes, the measurement list contains the
> > following kexec-cmdline data:
> >
> > 10 edc32d1e3a5ba7272280a395b6fb56a5ef7c78c3 ima-buf
> > sha256:4f43b7db850e
> > 88c49dfeffd4b1eb4f021d78033dfb05b07e45eec8d0b45275
> > kexec-cmdline
> > 726f6f
> > 743d2f6465762f7364613420726f2072642e6c756b732e757569643d6c756b73
> > 2d6637
> > 3633643737632d653236622d343431642d613734652d62363633636334643832
> > 656120
> > 696d615f706f6c6963793d7463627c61707072616973655f746362
> >
> > There's probably a better shell command, but the following works to
> > verify the digest locally against the /proc/cmdline:
> >
> > $ echo -n -e `cat /proc/cmdline | sed 's/^.*root=/root=/'` | sha256sum
> > 4f43b7db850e88c49dfeffd4b1eb4f021d78033dfb05b07e45eec8d0b4527f65  -
> >
> > If we leave the "buf" field as ascii-hex, what would the shell command
> > look like when verifying the digest based on the "buf" field?
> >
> > Mimi
> >
> To quickly test the sha256 i used the my /proc/cmdline
> ro quiet splash vt.handoff=1 ima_policy=tcb ima_appraise=fix
> ima_template_fmt=n-ng|d-ng|sig|buf ima_hash=sha256
> 
> export $VAL=
> 726f2071756965742073706c6173682076742e68616e646f66663d3120
> 696d615f706f6c6963793d74636220696d615f61707072616973653d666
> 97820696d615f74656d706c6174655f666d743d6e2d6e677c642d6e677c
> 7369677c62756620696d615f686173683d736861323536
> 
> echo -n -e $VAL | xxd -r -p | sha256sum
> 0d0b891bb730120d9593799cba1a7b3febf68f2bb81fb1304b0c963f95f6bc58  -
> 
> I will run it through the code as well, but the shell command should work.

Yes, that works.

sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements
| grep  kexec-cmdline | cut -d' ' -f 6 | xxd -r -p | sha256sum

Mimi

