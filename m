Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBFD2008EF
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2020 14:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgFSMoO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Jun 2020 08:44:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12174 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729367AbgFSMoN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Jun 2020 08:44:13 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05JCXiEx051063;
        Fri, 19 Jun 2020 08:44:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31runckdpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 08:44:04 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05JCYDCj053630;
        Fri, 19 Jun 2020 08:44:04 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31runckdp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 08:44:03 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05JCZ54g012883;
        Fri, 19 Jun 2020 12:44:02 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 31r0dvs272-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 12:44:01 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05JCgfxb60358958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jun 2020 12:42:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4B874203F;
        Fri, 19 Jun 2020 12:43:59 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A172B42045;
        Fri, 19 Jun 2020 12:43:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.188.214])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Jun 2020 12:43:58 +0000 (GMT)
Message-ID: <1592570638.17802.8.camel@linux.ibm.com>
Subject: Re: [LTP v2 1/1] ima_tpm.sh: Fix for calculating boot aggregate
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, Bruno Meneguele <bmeneg@redhat.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>, ltp@lists.linux.it,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Petr Cervinka <pcervinka@suse.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Maurizio Drocco <maurizio.drocco@ibm.com>
Date:   Fri, 19 Jun 2020 08:43:58 -0400
In-Reply-To: <20200619082134.GB23036@dell5510>
References: <20200527071434.28574-1-pvorel@suse.cz>
         <1590601280.16219.1.camel@linux.ibm.com> <20200528140747.GA8401@dell5510>
         <1590679145.4457.39.camel@linux.ibm.com> <20200528160527.GA27243@dell5510>
         <20200615194134.GF129694@glitch> <1592252491.11061.181.camel@linux.ibm.com>
         <20200617012148.hhpvxqov2py7fvvc@cantor> <20200617204500.GB40831@glitch>
         <20200619082134.GB23036@dell5510>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_11:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=909
 impostorscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 clxscore=1015 bulkscore=0 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190089
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-06-19 at 10:21 +0200, Petr Vorel wrote:
> Hi all,
> 
> ...
> > > > I'd appreciate if someone could send me a TPM event log, the PCRs, and
> > > > the associated IMA ascii_runtime_measurements "boot_aggregate" from a
> > > > system with a discrete TPM 2.0 with PCRs 8 & 9 events.
> 
> 
> > Maybe Maurizio already have it at hand?
> I'd appreciate to have these files as well.
> 
> > I can try to setup a system with grub2+tpm to get the log with pcr 8 and
> > 9 filled.

Both RHEL 8 and Ubuntu 20.04 LTS have PCRs 8 & 9.  I'll include one as
another example for the tests/boot_aggregate.test.

Mimi

