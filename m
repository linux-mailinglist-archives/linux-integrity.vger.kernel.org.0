Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A90223A8A0
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Aug 2020 16:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgHCOgy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Aug 2020 10:36:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29669 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726358AbgHCOgy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Aug 2020 10:36:54 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 073Ea1Rc028674;
        Mon, 3 Aug 2020 10:36:45 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32pktuhbmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 10:36:40 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 073EaInl029617;
        Mon, 3 Aug 2020 10:36:18 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32pktuhb39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 10:36:17 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 073EQpi3027845;
        Mon, 3 Aug 2020 14:34:16 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 32mynh29xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 14:34:16 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 073EYESp64029048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Aug 2020 14:34:14 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DE9611C058;
        Mon,  3 Aug 2020 14:34:14 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBEE211C052;
        Mon,  3 Aug 2020 14:34:12 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.52.50])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 Aug 2020 14:34:12 +0000 (GMT)
Message-ID: <4b871b62a6cdf63756fc0f0e5a2fd6b31c4fe4e8.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Vitaly Chikunov <vt@altlinux.org>, linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Date:   Mon, 03 Aug 2020 10:33:54 -0400
In-Reply-To: <20200803131117.GB30440@dell5510>
References: <20200731182408.696931-1-zohar@linux.ibm.com>
         <20200731182408.696931-6-zohar@linux.ibm.com>
         <20200731185633.kqgcz4dwfa4ruyld@altlinux.org>
         <20200731201808.GA27841@dell5510>
         <20200731202638.x5mnkz7hcpgbveu2@altlinux.org>
         <20200731204044.GC27841@dell5510>
         <c28c63ca748236c0db4594d2ddc2f5b63cd75528.camel@linux.ibm.com>
         <20200803131117.GB30440@dell5510>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_13:2020-08-03,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008030110
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-08-03 at 15:11 +0200, Petr Vorel wrote:
> Hi all,
> 
> > Thanks, Vitaly, Petr, for catching this.  SSL isn't define yet.   The
> > test should be removed.  If/when libressl is added, it would look like:
> > -     - env: TSS=ibmtss
> > -     - env: TSS=tpm2-tss
> > +     - env: TSS=ibmtss SSL=openssl
> > +     - env: TSS=ibmtss SSL=libressl;
> > +     - env: TSS=tpm2-tss SSL=openssl
> >  before_install:
> > +   - if [ "${SSL}" = "libressl" ]; then
> > +        ./tests/install-libressl.sh;
> > +     fi
> 
> FYI: Libressl is packaged for some distros (if docker based Travis is used):
> 
> https://pkgs.org/download/libressl

Good to know.   There's currently issues compiling ima-evm-utils with
libressl that need to be addressed.

Mimi

