Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA03F2550A2
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Aug 2020 23:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgH0Vek (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Aug 2020 17:34:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726243AbgH0Vej (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Aug 2020 17:34:39 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RLY3cw065226;
        Thu, 27 Aug 2020 17:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=flZ/2B0Hh0bZoxt4a1YxIiN0FS1j+WGfd+Vmasc/0vw=;
 b=pYNLvy22VVDseb+ajHQec53svFDULevItTdPozOTwo8F6nAyKVjNbOEjSIzvuu6LhiM6
 xb2zsc4SoUdTc6s8pgTcTgdKfKeJsQws9Z56yZgtsaeoZNq7/uURp6tUKsXmnHZF2V3L
 nSU4r7T4njVR1YA7axFjRo1IJBMrUokrQTqi1Mo8az1OCjG1AqSGNz2vo+tQQzHFNQqN
 HTqm9MKx7+N0s/xGkAPrkpUZ19nL0d7cqog8YYonsjZeUMhjbxqvyrCmAC6RKMpz4Vcd
 hm1y8c+45fNQxcZhPY8M3TwcPRUiboYy/qKi+veBLSfXHf/TtoyHfaMo9dd6exppM5S1 dA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 336m4hh4k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 17:34:29 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07RLSaTM009191;
        Thu, 27 Aug 2020 21:34:25 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 332uk6e3nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 21:34:25 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07RLYNUM66584996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 21:34:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18151AE04D;
        Thu, 27 Aug 2020 21:34:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1BB5AE051;
        Thu, 27 Aug 2020 21:34:21 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.6.101])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Aug 2020 21:34:21 +0000 (GMT)
Message-ID: <b72657042d13f9b8f30d5bdea7e2d06835e4a1d1.camel@linux.ibm.com>
Subject: Re: [LTP v4 4/5] IMA: Add a test to verify measurement of
 certificate imported into a keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 27 Aug 2020 17:34:20 -0400
In-Reply-To: <20200827135503.GA11990@dell5510>
References: <20200820090824.3033-1-pvorel@suse.cz>
         <20200820090824.3033-5-pvorel@suse.cz>
         <b58057275ecdc06bb512d39ea46118197f33c33f.camel@linux.ibm.com>
         <20200827132354.GA20439@dell5510> <20200827135503.GA11990@dell5510>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_14:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270162
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Thu, 2020-08-27 at 15:55 +0200, Petr Vorel wrote:

> > > > +	if ! tst_is_num $KEYRING_ID; then
> > > > +		tst_brk TBROK "unable to parse the new keyring id ('$KEYRING_ID')"
> > > > +	fi
> > > > +
> > > Instead of using TST_DATAROOT, which is defined as
> > > "$LTPROOT/datafiles", use LTPROOT directly to define the path to the
> > > cert.  Adding the following will allow the test to run from the build
> > > directory.
> > >       if [ ! -f $cert_file ]; then
> > >               cert_file="$LTPROOT/../datafiles/ima_keys/x509_ima.der"
> > >       fi
> > Yes, this will work if you set LTPROOT to <ltp git>/testcases/kernel/security/integrity/ima/tests/:

When running any of the tests from build tree test directory -
ltp/testcases/kernel/security/integrity/ima/tests, supplying LTPROOT
isn't necessary. "IMA: Refactor datafiles directory" broke running the
other tests directly from the build tree as well.

> > $ cd <ltp git>/testcases/kernel/security/integrity/ima/tests/
> > $ LTPROOT=$PWD PATH="../../../../../lib/:.:$PATH" ./ima_keys.sh
> > But, according to doc [1] $LTPROOT is "Prefix for installed LTP, the default is
> > /opt/ltp.". Using it like this is confusing (if we want to misuse $LTPROOT, one
> > would expect it's a cloned git root directory). Running from git root it'd have
> > to be:
> > $ cd <ltp git>
> > $ LTPROOT=$PWD/testcases/kernel/security/integrity/ima/tests/ \
> > PATH="testcases/lib:testcases/kernel/security/integrity/ima/tests/:$PATH" ima_keys.sh
> > TL;DR: I'd really prefer people run IMA from installed LTP (make && make install
> > in both testcases/lib and testcases/kernel/security/integrity/ima/ is just enough),
> > but I'll add this hack to make your testing easier :). But fixing this in
> > tst_test.sh is really needed.

I'm looking ...

> 
> Suggesting this diff from v4:
> 
> +	# hack when running ima_keys.sh locally from ima_keys.sh directory
> +	# LTPROOT=$PWD PATH="../../../../../lib/:.:$PATH" ./ima_keys.sh
> +	if [ ! -f "$cert_file" ]; then
> +		cert_file="$LTPROOT/../datafiles/ima_keys/x509_ima.der"
> +	fi
> 
> Visible also on
> https://github.com/pevik/ltp/tree/Lachlan_Sneff/ima_keys.sh-second-test.v4.fixes
> 
> Not sure if you still doing review & testing, thus waiting for your comments
> or tags.

Sorry, yes I'm planning to.

Mimi

> 
> Kind regards,
> Petr
> 
> > > Mimi
> > Kind regards,
> > Petr
> > [1] https://github.com/linux-test-project/ltp/wiki/User-Guidelines


