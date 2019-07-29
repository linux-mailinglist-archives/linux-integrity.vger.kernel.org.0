Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C52B78324
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jul 2019 03:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfG2BtY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 28 Jul 2019 21:49:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726251AbfG2BtY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 28 Jul 2019 21:49:24 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6T1kNKO128612
        for <linux-integrity@vger.kernel.org>; Sun, 28 Jul 2019 21:49:22 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u1mmfvug7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 28 Jul 2019 21:49:22 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 29 Jul 2019 02:49:20 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 29 Jul 2019 02:49:17 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6T1nG6456164366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jul 2019 01:49:16 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97BD611C04C;
        Mon, 29 Jul 2019 01:49:16 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E53111C04A;
        Mon, 29 Jul 2019 01:49:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.133])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Jul 2019 01:49:15 +0000 (GMT)
Subject: Re: [PATCH v2] ima-evm-utils: Add some tests for evmctl
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
Date:   Sun, 28 Jul 2019 21:49:04 -0400
In-Reply-To: <20190728234031.ucyu6fj4pvr4owd3@altlinux.org>
References: <20190727044113.3865-1-vt@altlinux.org>
         <1564334267.4245.420.camel@linux.ibm.com>
         <20190728234031.ucyu6fj4pvr4owd3@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19072901-0012-0000-0000-0000033722DC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072901-0013-0000-0000-00002170C26B
Message-Id: <1564364944.4245.452.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-28_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907290020
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-07-29 at 02:40 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Sun, Jul 28, 2019 at 01:17:47PM -0400, Mimi Zohar wrote:
> > On Sat, 2019-07-27 at 07:41 +0300, Vitaly Chikunov wrote:
> > > - Since I still edit all 5 files I did not split the patch into multiple
> > >   commits to separate the files, otherwise editing will become too
> > >   complicated, as I ought to continuously rebase and edit different
> > >   commits. This was really non-productive suggestion
> > 
> > Ok, but the review will be broken up.  For now, the comments below are
> > limited to tests/Makefile.am, tests/functions.sh and
> > tests/ima_hash.test.  Some of the comments are intrusive, so I'm going
> > to hold off on reviewing the other tests.
> 
> This is good, since I am reworking ima_sign/ima_verify tests into a single
> test that will also cover EVM sign/verify.
> 
> > Autotools generates "test-driver".  Should it be added to git-ignore?
> 
> Didn't notice this.
> 
> > Should we be using SPDX, at least for new files?
> 
> OK.
> 
> > > +    if ! type $i; then
> > 
> > "type" is a bashism.
> 
> Tests are on bash.
> 
> > > +# Define FAILEARLY to exit testing on the first error.
> > > +exit_early() {
> > > +  if [ $FAILEARLY ]; then
> > > +    exit $1
> > > +  fi
> > > +}
> > 
> > I would group all of the environment variable function checking
> > together at the top of functions.sh.
> 
> Some functions check VERBOSE should they be on top too?
> 
> Or you meant this is just variable checking function? It isn't.

There isn't a "Usage" or any documentation listing the environment
variables.  I'm suggesting to at least group them together.

> 
> > The functions "pos" and "neg" are written very concisely, but they are
> > part of a common set of functions, which are the crux of the tests
> > scripts.  I'm really hesitant about having common functions that
> > execute any command passed to it, without any form of verification.
> 
> What verification and why?

Even though the tests are not running as root, it's still executing
"$@", whatever that might be.  For ima_hash.test, the first argument
is "check".

> 
> > > +  set -- evmctl $V ${ENGINE:+--engine $ENGINE} "$@"
> > > +  echo $YELLOW$TMODE $*$NORM
> > > +  eval "$@" >$out 2>&1
> > 
> > Here at least the command is limited to "evmctl".
> 
> This is emvctl runner. pos/neg can and should run anything that needs
> their exit code be checked and accounted as test result.
> 
> > Is there any benefit to using "set --", as opposed to defining a local
> > variable and executing it?  Is this simply a question of style?
> 
> I will make it using variable.
> 
> > > +_enable_gost_engine() {
> > > +  # Do not enable if it's already working (enabled by user)
> > > +  if ! openssl md_gost12_256 /dev/null >/dev/null 2>&1 \
> > > +    && openssl engine gost >/dev/null 2>&1; then
> > > +    ENGINE=gost
> > > +  fi
> > > +}
> > 
> > With gost provided as an Openssl engine, is it possible to be able to
> > execute the first command without the gost engine enabled?  With
> > commit 782224f33cd7 ("ima-evm-utils: Rework openssl init"),
> 
> I don't understand question. What is 'first command'? `openssl
> md_gost12_256` will not work if gost-engine is not configured somehow.

Exactly.  "openssl md_gost12_256 /dev/null" (returns 0, but is
negated) will succeed only if the engine is enabled.  The "openssl
engine gost" test will never fail.

> 
> > I'm now wondering if the "--engine e' option is still needed?
> 
> It's needed. Why you thinking it doesn't? Commit 782224f33cd7 will not
> load gost (or any other) engine on its own.

If the gost engine is enabled in openssl.cnf then we don't need to set
"ENGINE=gost".  I'm obviously missing something here.

> 
> > > +# Check with constant
> > > +check_const() {
> > 
> > This function comment doesn't provide any more details than the
> > function name.  Please either rename this function (eg. check_xattr)
> > or expand the function comment.
> 
> OK.
> 
> (check* was supposed to be top-level tests. I will change this in v3.)
> 
> > > +  local alg=$1 pref=$2 hash=$3 file=$4
> > > +
> > > +  FOR=$alg DEL=$file 
> > 
> > Why not use ALG=$alg and FILE=$file as the global variable names?
> 
> check was called once for every algo. Are you proposing to change
> call like

Although "FOR" is capitalized, I was reading it as "for".  It took me
a while to realize that "FOR" and "DEL" are global variables being
used in "_evmctl_run".  Anything you can do to make it easier to read
would be appreciated.  Just adding comments would help.

> 
>   check_const sha1 0x01 sha1-hash.txt
> to
>   ALG=sha1 FILE=sha1-hash.txt
>   check_const 0x01
> ?
> 
> (I tried to put every mandatory argument into a argument list.)
> 
> > > +  cmd="openssl dgst ${ENGINE:+-engine $ENGINE} -$alg $file"
> > > +  echo - $cmd
> > > +  hash=$(set -o pipefail; eval "$cmd" 2>/dev/null | cut -d' ' -f2)
> > 
> > Is there a reason for not executing $cmd directly?  Is it safer
> > calling "pipefail" and "eval"?  Is this a question of style?
> 
> I will remove eval (it also don't let me pass empty arguments into
> called functions). `pipefail' is needed, so I can see exit code of
> $cmd and not of `cut' in $?.
> 
> > > +  if [ $? -ne 0 ] && _is_positive_test; then
> > > +    echo $CYAN"$alg test is skipped"$NORM
> > > +    rm $file
> > > +    return $SKIP
> > > +  fi
> > > +  check_const $alg $pref "$hash" $file
> > > +}
> > > +
> > > +# check args: algo prefix hex-hash
> > 
> > The first keyword - test type - is missing in the comment above.  It
> > would be clearer if instead of "pos" or "neg", the key words included
> > the words "pass" and "fail", to indicate that the test is expected to
> > pass or fail.
> 
> pass and fail looks like imperative statements, and not like something that
> will check other thing to pass or fail. I will rename them to something
> else.
> 
> Thanks for the review!

While further testing, "_require evmctl openssl" should also make sure
that getfattr is installed.

Mimi

